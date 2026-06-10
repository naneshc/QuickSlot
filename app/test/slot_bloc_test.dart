import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quickslot_app/core/errors/failures.dart';
import 'package:quickslot_app/core/utils/result.dart';
import 'package:quickslot_app/features/slots/domain/entities/slot_entity.dart';
import 'package:quickslot_app/features/slots/domain/usecases/book_slot.dart';
import 'package:quickslot_app/features/slots/domain/usecases/get_slots.dart';
import 'package:quickslot_app/features/slots/presentation/bloc/slot_bloc.dart';

class MockGetSlots extends Mock implements GetSlots {}
class MockBookSlot extends Mock implements BookSlot {}

void main() {
  late SlotBloc slotBloc;
  late MockGetSlots mockGetSlots;
  late MockBookSlot mockBookSlot;

  setUp(() {
    mockGetSlots = MockGetSlots();
    mockBookSlot = MockBookSlot();
    slotBloc = SlotBloc(getSlots: mockGetSlots, bookSlot: mockBookSlot);
  });

  tearDown(() {
    slotBloc.close();
  });

  test('initial state should be SlotInitial', () {
    expect(slotBloc.state, isA<SlotInitial>());
  });

  group('GetSlotsEvent testing', () {
    const tVenueId = 'venue_1';
    const tDate = '2026-06-11';
    const tSlotsList = [
      SlotEntity(timeSlot: '06:00-07:00', status: 'available'),
      SlotEntity(timeSlot: '07:00-08:00', status: 'booked', userId: 'user_2'),
    ];

    test('should emit [SlotLoading, SlotLoaded] when slots are fetched successfully', () async {
      // Arrange
      when(() => mockGetSlots(any(), any()))
          .thenAnswer((_) async => const Success(tSlotsList));

      // Act
      slotBloc.add(const GetSlotsEvent(venueId: tVenueId, date: tDate));

      // Assert
      await expectLater(
        slotBloc.stream,
        emitsInOrder([
          isA<SlotLoading>(),
          isA<SlotLoaded>().having((state) => state.slots, 'slots', tSlotsList),
        ]),
      );
      verify(() => mockGetSlots(tVenueId, tDate)).called(1);
    });

    test('should emit [SlotLoading, SlotError] when slots fetch fails', () async {
      // Arrange
      when(() => mockGetSlots(any(), any()))
          .thenAnswer((_) async => const FailureResult(ServerFailure('Connection Error')));

      // Act
      slotBloc.add(const GetSlotsEvent(venueId: tVenueId, date: tDate));

      // Assert
      await expectLater(
        slotBloc.stream,
        emitsInOrder([
          isA<SlotLoading>(),
          isA<SlotError>().having((state) => state.message, 'message', 'Connection Error'),
        ]),
      );
      verify(() => mockGetSlots(tVenueId, tDate)).called(1);
    });
  });
}
