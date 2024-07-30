import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String image;
  final int id;
  final int price;
  final int discount;
  final int rating;
  final String name;
  final String category;
  final int favorite;
  final String description;
  final String currency;

  const Product(
      {required this.image,
      required this.category,
      required this.id,
      required this.price,
      required this.name,
      required this.rating,
      required this.discount,
      required this.favorite,
      required this.description,
      required this.currency,
      });

  factory Product.fromJSON(Map<String, dynamic> json) => Product(
      image: json["image"],
      category: json["category"]["name"],
      id: json["id"],
      price: json["price"],
      name: json["name"],
      rating: json["rating"]["rate"],
      discount: json["discount"],
      favorite: json["favourite"],
    description: json["description"],
    currency: json["currency"],
  );

  @override
  List<Object?> get props =>
      [name, id, image, category, price, rating,currency, discount, favorite,description];
}

class Cart {
  final Map<Product, int> _products = {};
  double _finalPrice = 0;

  void addToCart(Product product, int quantity) {
    _products[product] = quantity;
  }

  void removeFromCart(Product product) {
    _products.remove(product);
  }

  Map<Product, int> getProducts() {
    return _products;
  }

  double getTotal() {
    _finalPrice = 0;
    for (var element in _products.entries) {
      double discount = element.key.discount.toDouble();
      double price = element.key.price.toDouble();
      int quantity = element.value;
      double cost = price * quantity * (1 - (discount / 100));
      _finalPrice = _finalPrice + cost;
    }
    return _finalPrice;
  }

  void emptyCart() {
    _products.clear();
  }
}
