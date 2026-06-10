import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/slot_entity.dart';

part 'slot_model.freezed.dart';
part 'slot_model.g.dart';

@freezed
abstract class SlotModel with _$SlotModel {
  const SlotModel._();

  const factory SlotModel({
    required String timeSlot,
    required String status,
    String? bookingId,
    String? userId,
  }) = _SlotModel;

  factory SlotModel.fromJson(Map<String, dynamic> json) => _$SlotModelFromJson(json);

  SlotEntity toEntity() {
    return SlotEntity(
      timeSlot: timeSlot,
      status: status,
      bookingId: bookingId,
      userId: userId,
    );
  }
}
