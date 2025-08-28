class CartModel {
  final int? id;
  final int? userId;
  final String? date;
  final List<CartProduct>? products;
  final int? iV;

  CartModel({this.id, this.userId, this.date, this.products, this.iV});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: json['products'] != null
          ? (json['products'] as List)
                .map((v) => CartProduct.fromJson(v))
                .toList()
          : null,
      iV: json['__v'],
    );
  }

  CartModel copyWith({
    int? id,
    int? userId,
    String? date,
    List<CartProduct>? products,
    int? iV,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
      iV: iV ?? this.iV,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'products': products?.map((v) => v.toJson()).toList(),
      '__v': iV,
    };
  }
}

class CartProduct {
  final int? productId;
  final int? quantity;

  CartProduct({this.productId, this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }

  CartProduct copyWith({int? productId, int? quantity}) {
    return CartProduct(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
