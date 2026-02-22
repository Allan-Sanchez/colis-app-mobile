import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_item.dart';

// ─── Model ────────────────────────────────────────────────────────────────────

class CartItem {
  final MenuItem item;
  final int quantity;

  const CartItem({required this.item, required this.quantity});

  CartItem copyWith({int? quantity}) =>
      CartItem(item: item, quantity: quantity ?? this.quantity);

  double get subtotal {
    final price = double.tryParse(item.price ?? '0') ?? 0;
    return price * quantity;
  }
}

class CartState {
  final int? restaurantId;
  final List<CartItem> items;

  const CartState({this.restaurantId, this.items = const []});

  bool get isEmpty => items.isEmpty;
  int get totalCount => items.fold(0, (sum, i) => sum + i.quantity);

  double get total => items.fold(0.0, (sum, i) => sum + i.subtotal);

  String get totalFormatted => total.toStringAsFixed(2);
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  /// Returns true if there is a conflict (different restaurant, cart not empty).
  /// Does NOT clear the cart — call [replaceCartAndAdd] after user confirms.
  bool addItem(MenuItem item, int restaurantId) {
    if (state.restaurantId != null &&
        state.restaurantId != restaurantId &&
        state.items.isNotEmpty) {
      return true; // conflict — caller must show dialog
    }
    _doAdd(item, restaurantId);
    return false;
  }

  /// Clears the current cart and adds [item]. Call only after user confirms.
  void replaceCartAndAdd(MenuItem item, int restaurantId) {
    state = const CartState();
    _doAdd(item, restaurantId);
  }

  void _doAdd(MenuItem item, int restaurantId) {
    final index = state.items.indexWhere((ci) => ci.item.id == item.id);
    final List<CartItem> newItems;

    if (index >= 0) {
      newItems = [...state.items];
      newItems[index] = newItems[index].copyWith(
        quantity: newItems[index].quantity + 1,
      );
    } else {
      newItems = [...state.items, CartItem(item: item, quantity: 1)];
    }

    state = CartState(restaurantId: restaurantId, items: newItems);
  }

  void removeItem(int menuItemId) {
    final newItems =
        state.items.where((ci) => ci.item.id != menuItemId).toList();
    state = CartState(
      restaurantId: newItems.isEmpty ? null : state.restaurantId,
      items: newItems,
    );
  }

  void updateQuantity(int menuItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(menuItemId);
      return;
    }
    final newItems = state.items.map((ci) {
      return ci.item.id == menuItemId ? ci.copyWith(quantity: quantity) : ci;
    }).toList();
    state = CartState(restaurantId: state.restaurantId, items: newItems);
  }

  void clear() => state = const CartState();
}

// ─── Providers ────────────────────────────────────────────────────────────────

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

final cartCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).totalCount;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).total;
});
