class Product {
  final int? id;
  final String name;
  final DateTime expiryDate;

  Product({this.id, required this.name, required this.expiryDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      expiryDate: DateTime.parse(map['expiryDate']),
    );
  }
}