import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<ProductService>(context, listen: false)
            .deleteProduct(product.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} 삭제됨')),
        );
      },
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('유통기한: ${product.expiryDate.toString().split(' ')[0]}'),
        trailing: _buildExpiryIndicator(product.expiryDate),
      ),
    );
  }

  Widget _buildExpiryIndicator(DateTime expiryDate) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    Color color;
    if (daysUntilExpiry <= 3) {
      color = Colors.red;
    } else if (daysUntilExpiry <= 7) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$daysUntilExpiry일',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}