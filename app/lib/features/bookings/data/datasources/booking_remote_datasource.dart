import 'dart:convert';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getUserBookings(String userId);
  Future<void> cancelBooking(String bookingId);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiClient apiClient;

  BookingRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      final response = await apiClient.get('/users/$userId/bookings');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BookingModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ServerException(
          message: 'Server returned code: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to fetch user bookings from API');
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    try {
      final response = await apiClient.delete('/bookings/$bookingId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else {
        String errMsg = 'Failed to cancel booking';
        try {
          final bodyJson = jsonDecode(response.body);
          errMsg = bodyJson['error'] ?? errMsg;
        } catch (_) {}
        
        throw ServerException(
          message: errMsg,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception('Network error during booking cancellation');
    }
  }
}
