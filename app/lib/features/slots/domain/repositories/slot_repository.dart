import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/slot_entity.dart';

abstract class SlotRepository {
  Future<Result<List<SlotEntity>, Failure>> getSlots(String venueId, String date);
  Future<Result<void, Failure>> bookSlot(String venueId, String date, String timeSlot);
}
