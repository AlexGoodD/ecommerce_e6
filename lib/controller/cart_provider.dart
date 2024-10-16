import 'package:super_store_e_commerce_flutter/imports.dart';

class CartProvider with ChangeNotifier {
  final List<CartModel> _items = [];

  List<CartModel> get items => [..._items];

  int get itemCount => _items.length;

  // Método para calcular el total usando Isolates.
  Future<int> totalPrice() async {
    // Extraer los precios y cantidades en un formato serializable.
    final itemsData = _items.map((item) {
      return {'price': item.price, 'quantity': item.quantity};
    }).toList();

    // Usar compute para mover el cálculo a un isolate.
    final total = await compute(_calculateTotalPrice, itemsData);

    if (kDebugMode) {
      print('Total Price: $total');
    }

    return total;
  }

  // Función que se ejecuta en un isolate.
  static int _calculateTotalPrice(List<Map<String, dynamic>> items) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item['price'] * item['quantity'];
    }
    return totalPrice.round();
  }

  void addItem(CartModel cartModel) {
    int index = _items.indexWhere((item) => item.id == cartModel.id);
    if (index != -1) {
      CartModel existingItem = _items[index];
      CartModel updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity! + cartModel.quantity!,
        totalPrice: existingItem.totalPrice! + cartModel.totalPrice!,
      );
      _items[index] = updatedItem;
    } else {
      _items.add(cartModel);
    }
    notifyListeners();
  }

  void increaseQuantity(int id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items[index].quantity = _items[index].quantity! + 1;
    _items[index].totalPrice = _items[index].price! * _items[index].quantity!;
    notifyListeners();
  }

  void decreaseQuantity(int id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (_items[index].quantity! > 1) {
      _items[index].quantity = _items[index].quantity! - 1;
      _items[index].totalPrice = _items[index].price! * _items[index].quantity!;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}