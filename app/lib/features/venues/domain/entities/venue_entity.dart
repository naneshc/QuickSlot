class VenueEntity {
  final String id;
  final String name;
  final String type;
  final String location;
  final String imageUrl;
  final double pricePerHour;
  final double rating;
  final String description;

  const VenueEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.imageUrl,
    required this.pricePerHour,
    required this.rating,
    required this.description,
  });
}
