class CartModel {
  final String username;
  final String title;
  final double price;
  final String thumbnail;
  final int qty;

  CartModel({
    required this.username,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.qty,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'qty': qty,
    };
   }

  factory CartModel.fromMap(Map map) {
    return CartModel(
      username: map['username'],
      title: map['title'],
      price: (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'],
      qty: map['qty'],
    );
  }
}