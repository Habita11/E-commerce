import 'package:matjary/config/images.dart';

class Product {
  String image;
  int id;
  double price;
  double discount;
  double rating;
  String name;
  String category;

  Product(
      {required this.image,
      required this.category,
      required this.id,
      required this.price,
      required this.name,
      required this.rating,
      required this.discount,
      });
}

class Cart {
  Map<Product, int> _products = {};
  double _finalPrice=0;

  void addToCart(Product product, int quantity) {
    _products[product] = quantity;
  }
  void removeFromCart(Product product){
    _products.remove(product);
  }
  Map<Product,int> getProducts(){
    return _products;
  }
  double getTotal(){
    _finalPrice=0;
    _products.entries.forEach((element){
      double discount=element.key.discount;
      double price=element.key.price;
      int quantity=element.value;
      double cost=price*quantity*(1-discount);
      _finalPrice=_finalPrice+cost;
    });
    return _finalPrice;
  }
  void emptyCart(){
    _products.clear();
  }
}

List<Product> products = [
  Product(
      discount: .11,
      image: AppImages.iphone,
      category: "موبايلات",
      id: 1,
      price: 250,
      name: "موبايل ابل ايفون 13 (128 جيجابايت) ",
      rating: 4
  ),
  Product(
      discount: .55,
      image: AppImages.samsungA,
      category: "موبايلات",
      id: 2,
      price: 200,
      name: "موبايل سامسونج a30 (128 جيجابايت)",
      rating: 5
  ),
  Product(
      discount: .25,
      image: AppImages.iphone,
      category: "موبايلات",
      id: 3,
      price: 350,
      name: "موبايل ابل ايفون 11 (128 جيجابايت) ",
      rating: 3
  ),
  Product(
      discount: .2,
      image: AppImages.samsungA,
      category: "موبايلات",
      id: 4,
      price: 350,
      name: "موبايل سامسونج a23 (128 جيجابايت) ",
      rating: 4
  ),
  Product(
      discount: .3,
      image: AppImages.iphone,
      category: "موبايلات",
      id: 5,
      price: 550,
      name: "موبايل ابل ايفون 14 (128 جيجابايت) شاشة سوبر ريتينا XDR",
      rating: 5
  ),
];
