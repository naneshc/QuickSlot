// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SlotModel _$SlotModelFromJson(Map<String, dynamic> json) => _SlotModel(
  timeSlot: json['timeSlot'] as String,
  status: json['status'] as String,
  bookingId: json['bookingId'] as String?,
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$SlotModelToJson(_SlotModel instance) =>
    <String, dynamic>{
      'timeSlot': instance.timeSlot,
      'status': instance.status,
      'bookingId': instance.bookingId,
      'userId': instance.userId,
    };
