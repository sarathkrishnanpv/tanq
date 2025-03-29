class RideType {
  final String name;
  final String image;
  final String? description;
  final double? price;
  final int? seats;
  final String? tag;

  RideType({
    required this.name,
    required this.image,
    this.description,
    this.price,
    this.seats,
    this.tag,
  });
}

class SuggestedRide {
  final String name;
  final String image;
  final String description;
  final String? tag;

  SuggestedRide({
    required this.name,
    required this.image,
    required this.description,
    this.tag,
  });
}

class RecentLocation {
  final String name;
  final String location;
  final String? subtitle;

  RecentLocation({
    required this.name,
    required this.location,
    this.subtitle,
  });
}
