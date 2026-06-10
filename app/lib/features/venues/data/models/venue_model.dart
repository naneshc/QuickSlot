import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/venue_entity.dart';

part 'venue_model.freezed.dart';
part 'venue_model.g.dart';

@freezed
abstract class VenueModel with _$VenueModel {
  const VenueModel._();

  const factory VenueModel({
    required String id,
    required String name,
    required String type,
    required String location,
    required String imageUrl,
    required double pricePerHour,
    required double rating,
    required String description,
  }) = _VenueModel;

  factory VenueModel.fromJson(Map<String, dynamic> json) => _$VenueModelFromJson(json);

  VenueEntity toEntity() {
    return VenueEntity(
      id: id,
      name: name,
      type: type,
      location: location,
      imageUrl: imageUrl,
      pricePerHour: pricePerHour.toDouble(),
      rating: rating.toDouble(),
      description: description,
    );
  }
}
