import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_response.dart';
import '../providers/cart_provider.dart';

class CreatedOrder {
  final int id;
  final String status;
  final String totalAmount;

  CreatedOrder({
    required this.id,
    required this.status,
    required this.totalAmount,
  });

  factory CreatedOrder.fromJson(Map<String, dynamic> json) {
    return CreatedOrder(
      id: json['id'] as int,
      status: json['status'] as String,
      totalAmount: json['totalAmount']?.toString() ?? '0',
    );
  }
}

class OrderRepository {
  final Dio _dio;

  OrderRepository(this._dio);

  Future<ApiResponse<CreatedOrder>> createOrder({
    required int restaurantId,
    required String customerName,
    required String customerPhone,
    String? notes,
    required List<CartItem> items,
  }) async {
    final total = items.fold(0.0, (sum, ci) => sum + ci.subtotal);

    final body = {
      'restaurantId': restaurantId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'notes': notes,
      'totalAmount': total.toStringAsFixed(2),
      'items': items
          .map((ci) => {
                'menuItemId': ci.item.id,
                'menuItemTitle': ci.item.title,
                'quantity': ci.quantity,
                'unitPrice':
                    (double.tryParse(ci.item.price ?? '0') ?? 0).toStringAsFixed(2),
                'subtotal': ci.subtotal.toStringAsFixed(2),
              })
          .toList(),
    };

    final response = await _dio.post(ApiConstants.orders, data: body);
    return ApiResponse.fromJson(
      response.data,
      (json) => CreatedOrder.fromJson(json as Map<String, dynamic>),
    );
  }
}
