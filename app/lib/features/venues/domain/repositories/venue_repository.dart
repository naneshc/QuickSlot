import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/venue_entity.dart';

abstract class VenueRepository {
  Future<Result<List<VenueEntity>, Failure>> getVenues();
}
