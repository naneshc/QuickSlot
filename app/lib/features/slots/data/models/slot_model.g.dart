// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlotModelImpl _$$SlotModelImplFromJson(Map<String, dynamic> json) =>
    _$SlotModelImpl(
      timeSlot: json['timeSlot'] as String,
      status: json['status'] as String,
      bookingId: json['bookingId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$SlotModelImplToJson(_$SlotModelImpl instance) =>
    <String, dynamic>{
      'timeSlot': instance.timeSlot,
      'status': instance.status,
      'bookingId': instance.bookingId,
      'userId': instance.userId,
    };
