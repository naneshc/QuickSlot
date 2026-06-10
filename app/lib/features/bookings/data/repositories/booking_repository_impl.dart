import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Result<List<BookingEntity>, Failure>> getUserBookings(String userId) async {
    final cacheKey = 'bookings_cache_$userId';
    try {
      // 1. Try to fetch from remote
      final models = await remoteDataSource.getUserBookings(userId);

      // 2. Cache successful result
      final jsonString = jsonEncode(models.map((m) => m.toJson()).toList());
      await sharedPreferences.setString(cacheKey, jsonString);

      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } catch (e) {
      // 3. Fallback to offline cache
      final cachedJsonString = sharedPreferences.getString(cacheKey);
      if (cachedJsonString != null) {
        try {
          final List<dynamic> jsonList = jsonDecode(cachedJsonString);
          final entities = jsonList
              .map((json) => BookingModel.fromJson(json as Map<String, dynamic>).toEntity())
              .toList();
          return Success(entities);
        } catch (_) {
          return FailureResult(const CacheFailure('Failed to parse cached bookings'));
        }
      }
      return FailureResult(ServerFailure('Connection failed, and no offline cache exists.\n${e.toString()}'));
    }
  }

  @override
  Future<Result<void, Failure>> cancelBooking(String bookingId) async {
    try {
      await remoteDataSource.cancelBooking(bookingId);
      return const Success(null);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message, statusCode: e.statusCode, errorCode: e.errorCode));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
