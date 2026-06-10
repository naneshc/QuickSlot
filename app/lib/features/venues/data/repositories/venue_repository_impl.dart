import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/repositories/venue_repository.dart';
import '../datasources/venue_remote_datasource.dart';

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;

  VenueRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<VenueEntity>, Failure>> getVenues() async {
    try {
      final models = await remoteDataSource.getVenues();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }
}
