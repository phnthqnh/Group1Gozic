class ProductResponse {
  final int id;
  final String category_name;
  final String name;
  final String price;
  final String description;
  final String image;
  final int category;

  ProductResponse({
    required this.id,
    required this.category_name,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] ?? 0,
      category_name: json['category_name'] ?? "",
      name: json['name'] ?? "",
      price: json['price'] ?? "",
      description: json['description'] ?? "",
      image: json['image'] ?? "",
      category: json['category'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_name": category_name,
      "name": name,
      "price": price,
      "description": description,
      "image": image,
      "category": category,
    };
  }
}
