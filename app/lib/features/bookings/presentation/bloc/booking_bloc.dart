import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/get_user_bookings.dart';
import '../../domain/usecases/cancel_booking.dart';

abstract class BookingEvent {
  const BookingEvent();
}

class GetUserBookingsEvent extends BookingEvent {
  final String userId;
  const GetUserBookingsEvent(this.userId);
}

class CancelBookingEvent extends BookingEvent {
  final String bookingId;
  final String userId;

  const CancelBookingEvent({
    required this.bookingId,
    required this.userId,
  });
}

abstract class BookingState {
  const BookingState();
}

class BookingInitial extends BookingState {
  const BookingInitial();
}

class BookingLoading extends BookingState {
  const BookingLoading();
}

class BookingLoaded extends BookingState {
  final List<BookingEntity> bookings;
  const BookingLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String message;
  const BookingError(this.message);
}

class BookingCancelInProgress extends BookingState {
  const BookingCancelInProgress();
}

class BookingCancelSuccess extends BookingState {
  const BookingCancelSuccess();
}

class BookingCancelFailure extends BookingState {
  final String message;
  const BookingCancelFailure(this.message);
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetUserBookings getUserBookings;
  final CancelBooking cancelBooking;

  BookingBloc({
    required this.getUserBookings,
    required this.cancelBooking,
  }) : super(const BookingInitial()) {
    on<GetUserBookingsEvent>((event, emit) async {
      emit(const BookingLoading());
      final result = await getUserBookings(event.userId);
      result.fold(
        (bookings) => emit(BookingLoaded(bookings)),
        (failure) => emit(BookingError(failure.message)),
      );
    });

    on<CancelBookingEvent>((event, emit) async {
      emit(const BookingCancelInProgress());
      
      final result = await cancelBooking(event.bookingId);
      
      result.fold(
        (_) {
          emit(const BookingCancelSuccess());
        },
        (failure) {
          emit(BookingCancelFailure(failure.message));
        },
      );
    });
  }
}
