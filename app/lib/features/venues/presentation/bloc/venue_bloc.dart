import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/venue_entity.dart';
import '../../domain/usecases/get_venues.dart';

abstract class VenueEvent {
  const VenueEvent();
}

class GetVenuesEvent extends VenueEvent {
  const GetVenuesEvent();
}

abstract class VenueState {
  const VenueState();
}

class VenueInitial extends VenueState {
  const VenueInitial();
}

class VenueLoading extends VenueState {
  const VenueLoading();
}

class VenueLoaded extends VenueState {
  final List<VenueEntity> venues;
  const VenueLoaded(this.venues);
}

class VenueError extends VenueState {
  final String message;
  const VenueError(this.message);
}

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final GetVenues getVenues;

  VenueBloc(this.getVenues) : super(const VenueInitial()) {
    on<GetVenuesEvent>((event, emit) async {
      emit(const VenueLoading());
      final result = await getVenues();
      result.fold(
        (venues) => emit(VenueLoaded(venues)),
        (failure) => emit(VenueError(failure.message)),
      );
    });
  }
}
