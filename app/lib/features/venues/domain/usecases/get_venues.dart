import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/venue_entity.dart';
import '../repositories/venue_repository.dart';

class GetVenues {
  final VenueRepository repository;

  GetVenues(this.repository);

  Future<Result<List<VenueEntity>, Failure>> call() async {
    return await repository.getVenues();
  }
}
