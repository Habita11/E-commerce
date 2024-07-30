class Country {
  int id;
  String countryName;
  String countryKey;
  String countryCode;
  String flag;

  Country(
      {required this.id,
      required this.countryCode,
      required this.countryKey,
      required this.countryName,
      required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      id: json["id"],
      countryCode: json["country_code"],
      countryKey: json["country_key"],
      countryName: json["name"],
      flag: json["flag"]);
}
