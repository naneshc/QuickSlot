import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/slot_entity.dart';
import '../repositories/slot_repository.dart';

class GetSlots {
  final SlotRepository repository;

  GetSlots(this.repository);

  Future<Result<List<SlotEntity>, Failure>> call(String venueId, String date) async {
    return await repository.getSlots(venueId, date);
  }
}
