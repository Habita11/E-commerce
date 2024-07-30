
import 'package:equatable/equatable.dart';

class Categories extends Equatable{
  final int id;
  final String name;
  final String image;

  const Categories({
    required this.image,
    required this.name,
    required this.id
  });

  factory Categories.fromJSON(Map<String, dynamic> json)=>
      Categories(
          image: json["image"],
          name: json["name"],
          id: json["id"]
      );

  @override

  List<Object?> get props => [
    image,name,id
  ];


}