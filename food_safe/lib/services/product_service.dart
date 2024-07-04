import 'package:flutter/foundation.dart';
import '../models/product.dart';
import 'database_helper.dart';

class ProductService with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ProductService() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    _products = await _databaseHelper.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final id = await _databaseHelper.insertProduct(product);
    _products.add(Product(id: id, name: product.name, expiryDate: product.expiryDate));
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    await _databaseHelper.deleteProduct(id);
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}