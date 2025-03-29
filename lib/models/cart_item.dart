class CartItem {
  final String name;
  final String brand;
  final String image;
  final double price;
  final double? originalPrice;
  final String? discountPercentage;
  final int quantity;
  final bool isUpcoming;
  final DateTime? arrivalDate;

  CartItem({
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    this.originalPrice,
    this.discountPercentage,
    this.quantity = 1,
    this.isUpcoming = false,
    this.arrivalDate,
  });

  double get total => price * quantity;

  CartItem copyWith({
    String? name,
    String? brand,
    String? image,
    double? price,
    double? originalPrice,
    String? discountPercentage,
    int? quantity,
    bool? isUpcoming,
    DateTime? arrivalDate,
  }) {
    return CartItem(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      quantity: quantity ?? this.quantity,
      isUpcoming: isUpcoming ?? this.isUpcoming,
      arrivalDate: arrivalDate ?? this.arrivalDate,
    );
  }
}
