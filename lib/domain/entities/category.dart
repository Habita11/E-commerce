class Categories {
  final int id;
  final String name;
  final String image;

  Categories({
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
}