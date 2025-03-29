class RideOption {
  final String name;
  final String time;
  final String distance;
  final String description;
  final double price;
  final int seats;
  final String? tag;
  final String vehicleType;

  RideOption({
    required this.name,
    required this.time,
    required this.distance,
    required this.description,
    required this.price,
    required this.seats,
    this.tag,
    required this.vehicleType,
  });
}
