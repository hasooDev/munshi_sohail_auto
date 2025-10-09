import 'package:get/get.dart';

class CartController extends GetxController {
  /// Map<productId, quantity>
  RxMap<int, int> cart = <int, int>{}.obs;

  void addToCart(int productId) {
    if (cart.containsKey(productId)) {
      cart[productId] = cart[productId]! + 1;
    } else {
      cart[productId] = 1;
    }
  }

  void removeFromCart(int productId) {
    if (!cart.containsKey(productId)) return;

    if (cart[productId]! > 1) {
      cart[productId] = cart[productId]! - 1;
    } else {
      cart.remove(productId);
    }
  }

  void deleteItem(int productId) {
    cart.remove(productId);
  }

  void clearCart() {
    cart.clear();
  }

  int get totalItems =>
      cart.values.fold(0, (previous, current) => previous + current);
}
