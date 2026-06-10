import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
abstract class BookingModel with _$BookingModel {
  const BookingModel._();

  const factory BookingModel({
    required String id,
    required String venueId,
    required String venueName,
    required String location,
    required String imageUrl,
    required String date,
    required String timeSlot,
    required String userId,
    required String bookedAt,
    required String status,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      venueId: venueId,
      venueName: venueName,
      location: location,
      imageUrl: imageUrl,
      date: date,
      timeSlot: timeSlot,
      userId: userId,
      bookedAt: bookedAt,
      status: status,
    );
  }
}
