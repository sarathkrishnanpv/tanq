import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/models/cart_item.dart';


class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    addItem(
      CartItem(
        name: 'iPhone Mobile 16',
        brand: 'Apple',
        image: Assets.images.normal.iphone.path,
        price: 69190,
        originalPrice: 71934,
        discountPercentage: '12',
        quantity: 1,
      ),
    );
  }

  void addItem(CartItem item) {
    items.add(item);
  }

  void removeItem(CartItem item) {
    items.remove(item);
  }

  void incrementQuantity(CartItem item) {
    final index = items.indexOf(item);
    if (index != -1) {
      items[index] = item.copyWith(quantity: item.quantity + 1);
    }
  }

  void decrementQuantity(CartItem item) {
    final index = items.indexOf(item);
    if (index != -1 && item.quantity > 1) {
      items[index] = item.copyWith(quantity: item.quantity - 1);
    }
  }

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  double get discount => 0.0;

  double get total => subtotal - discount;

  String formatPrice(double price) {
    return '₹${price.toStringAsFixed(2)}';
  }
}
