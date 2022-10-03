// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product(
      {required this.available,
      this.imagen,
      required this.name,
      required this.price,
      this.id});

  bool available;
  String? imagen;
  String name;
  double price;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        imagen: json["imagen"],
        name: json["name"],
        price: json["price"].toDouble() ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "imagen": imagen,
        "name": name,
        "price": price,
      };

  Product copy() => Product(
      available: available, name: name, price: price, id: id, imagen: imagen);
}
