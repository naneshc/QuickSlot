import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/slot_entity.dart';
import '../../domain/usecases/get_slots.dart';
import '../../domain/usecases/book_slot.dart';

abstract class SlotEvent {
  const SlotEvent();
}

class GetSlotsEvent extends SlotEvent {
  final String venueId;
  final String date;
  final bool isSilent; // If true, don't show full-screen loading spinner (for polling)

  const GetSlotsEvent({
    required this.venueId,
    required this.date,
    this.isSilent = false,
  });
}

class BookSlotEvent extends SlotEvent {
  final String venueId;
  final String date;
  final String timeSlot;

  const BookSlotEvent({
    required this.venueId,
    required this.date,
    required this.timeSlot,
  });
}

abstract class SlotState {
  const SlotState();
}

class SlotInitial extends SlotState {
  const SlotInitial();
}

class SlotLoading extends SlotState {
  const SlotLoading();
}

class SlotLoaded extends SlotState {
  final List<SlotEntity> slots;
  final String venueId;
  final String date;
  final String? bookingSlotTime; // The slot currently being booked (shows inline loader)

  const SlotLoaded({
    required this.slots,
    required this.venueId,
    required this.date,
    this.bookingSlotTime,
  });

  SlotLoaded copyWith({
    List<SlotEntity>? slots,
    String? venueId,
    String? date,
    String? bookingSlotTime,
    bool clearBookingSlot = false,
  }) {
    return SlotLoaded(
      slots: slots ?? this.slots,
      venueId: venueId ?? this.venueId,
      date: date ?? this.date,
      bookingSlotTime: clearBookingSlot ? null : (bookingSlotTime ?? this.bookingSlotTime),
    );
  }
}

class SlotError extends SlotState {
  final String message;
  const SlotError(this.message);
}

// Action States
class BookingLoading extends SlotState {
  const BookingLoading();
}

class BookingSuccess extends SlotState {
  final String venueId;
  final String date;
  const BookingSuccess({required this.venueId, required this.date});
}

class BookingFailure extends SlotState {
  final String message;
  final String? errorCode;
  final String venueId;
  final String date;

  const BookingFailure({
    required this.message,
    this.errorCode,
    required this.venueId,
    required this.date,
  });
}

class SlotBloc extends Bloc<SlotEvent, SlotState> {
  final GetSlots getSlots;
  final BookSlot bookSlot;

  SlotBloc({
    required this.getSlots,
    required this.bookSlot,
  }) : super(const SlotInitial()) {
    on<GetSlotsEvent>((event, emit) async {
      // If the event is silent or we are already loaded, we don't clear the screen
      final currentState = state;
      if (!event.isSilent && currentState is! SlotLoaded) {
        emit(const SlotLoading());
      }

      final result = await getSlots(event.venueId, event.date);
      
      result.fold(
        (slots) {
          emit(SlotLoaded(
            slots: slots,
            venueId: event.venueId,
            date: event.date,
          ));
        },
        (failure) {
          // If silent fetch failed, keep current state if it's Loaded, otherwise show error
          if (event.isSilent && currentState is SlotLoaded) {
            // Keep current loaded state
          } else {
            emit(SlotError(failure.message));
          }
        },
      );
    });

    on<BookSlotEvent>((event, emit) async {
      final currentState = state;
      List<SlotEntity> currentSlots = [];
      
      if (currentState is SlotLoaded) {
        currentSlots = currentState.slots;
        // Mark the slot as "booking in progress"
        emit(currentState.copyWith(bookingSlotTime: event.timeSlot));
      } else {
        emit(const BookingLoading());
      }

      final result = await bookSlot(event.venueId, event.date, event.timeSlot);

      result.fold(
        (_) {
          emit(BookingSuccess(venueId: event.venueId, date: event.date));
        },
        (failure) {
          emit(BookingFailure(
            message: failure.message,
            errorCode: failure.errorCode,
            venueId: event.venueId,
            date: event.date,
          ));
        },
      );
    });
  }
}
