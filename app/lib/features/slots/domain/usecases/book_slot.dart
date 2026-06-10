import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/slot_repository.dart';

class BookSlot {
  final SlotRepository repository;

  BookSlot(this.repository);

  Future<Result<void, Failure>> call(String venueId, String date, String timeSlot) async {
    return await repository.bookSlot(venueId, date, timeSlot);
  }
}
