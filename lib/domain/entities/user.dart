class User {
  int id;
  String name;
  String phone;
  String countryCode;
  String? currency;
  String image;
  String language;
  int? isVerified;
  String? token;
  User({
    required this.id,
    required this.countryCode,
    required this.name,
    required this.image,
    required this.phone,
    required this.currency,
    required this.isVerified,
    required this.language,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic>json)=>
      User(id: json["user"]["id"],
          countryCode: json["user"]["country_code"],
          name: json["user"]["name"],
          image:json["user"]["image"],
          phone:json["user"]["phone"],
          currency: json["user"]["currency"],
          isVerified: json["user"]["is_verified"],
          language: json["user"]["language"],
          token: json["token"]
      );
  @override
  String toString() {

    return "name : $name , phone : $phone";
  }

}
