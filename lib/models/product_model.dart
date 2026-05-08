class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final int stock;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.thumbnail,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }
}