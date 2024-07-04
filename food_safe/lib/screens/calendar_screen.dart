import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('유통기한 캘린더'),
      ),
      body: Consumer<ProductService>(
        builder: (context, productService, child) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: (day) {
                  return productService.products
                      .where((product) => isSameDay(product.expiryDate, day))
                      .toList();
                },
              ),
              Expanded(
                child: _buildProductList(productService.products),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    if (_selectedDay == null) return Container();

    final productsOnSelectedDay = products
        .where((product) => isSameDay(product.expiryDate, _selectedDay!))
        .toList();

    if (productsOnSelectedDay.isEmpty) {
      return Center(child: Text('이 날짜에 유통기한이 끝나는 상품이 없습니다.'));
    }

    return ListView.builder(
      itemCount: productsOnSelectedDay.length,
      itemBuilder: (context, index) {
        final product = productsOnSelectedDay[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('유통기한: ${product.expiryDate.toString().split(' ')[0]}'),
        );
      },
    );
  }
}