import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import 'camera_screen.dart';
import 'calendar_screen.dart';
import '../widgets/product_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodSafe'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CalendarScreen()),
            ),
          ),
        ],
      ),
      body: Consumer<ProductService>(
        builder: (context, productService, child) {
          final products = productService.products;
          return products.isEmpty
              ? Center(child: Text('상품을 추가해주세요'))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(product: products[index]);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CameraScreen()),
        ),
        child: Icon(Icons.camera_alt),
        tooltip: '유통기한 스캔',
      ),
    );
  }
}