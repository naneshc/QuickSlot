// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingModelImpl _$$BookingModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingModelImpl(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      venueName: json['venueName'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      date: json['date'] as String,
      timeSlot: json['timeSlot'] as String,
      userId: json['userId'] as String,
      bookedAt: json['bookedAt'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$BookingModelImplToJson(_$BookingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venueId': instance.venueId,
      'venueName': instance.venueName,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'date': instance.date,
      'timeSlot': instance.timeSlot,
      'userId': instance.userId,
      'bookedAt': instance.bookedAt,
      'status': instance.status,
    };
