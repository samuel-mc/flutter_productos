import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'productos-back-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  late Product selectedProduct;

  File? newPictureFile;

  bool isLoading = false;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    products.clear();
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);
    isLoading = true;

    final Map<String, dynamic> productsMapped = json.decode(response.body);
    productsMapped.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
  }

  Future saveProduct(Product product) async {
    isSaving = true;
    if (product.id != null) {
      await updateProduct(product);
    } else {
      await createProduct(product);
    }
    isSaving = false;
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());
    final decodeData = response.statusCode;

    if (decodeData == 200) {
      loadProducts();
    }

    return product.id!;
  }

  Future createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: product.toJson());
    final decodedData = json.decode(response.body);
    product.id = decodedData['name'];

    products.add(product);
    notifyListeners();
  }

  void setProductImage(String path) {
    selectedProduct.imagen = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }
}
