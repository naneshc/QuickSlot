import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/slot_entity.dart';
import '../../domain/repositories/slot_repository.dart';
import '../datasources/slot_remote_datasource.dart';

class SlotRepositoryImpl implements SlotRepository {
  final SlotRemoteDataSource remoteDataSource;

  SlotRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<SlotEntity>, Failure>> getSlots(String venueId, String date) async {
    try {
      final models = await remoteDataSource.getSlots(venueId, date);
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message, statusCode: e.statusCode, errorCode: e.errorCode));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> bookSlot(String venueId, String date, String timeSlot) async {
    try {
      await remoteDataSource.bookSlot(venueId, date, timeSlot);
      return const Success(null);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message, statusCode: e.statusCode, errorCode: e.errorCode));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
