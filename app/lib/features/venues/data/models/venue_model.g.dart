// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VenueModelImpl _$$VenueModelImplFromJson(Map<String, dynamic> json) =>
    _$VenueModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$VenueModelImplToJson(_$VenueModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'pricePerHour': instance.pricePerHour,
      'rating': instance.rating,
      'description': instance.description,
    };
