class AddTownship{
  final String country_id;
  final String city_id;
  final String name;

  AddTownship({required this.country_id, required this.name,required this.city_id});

  Map<String,dynamic> toJson() {
    return {
      'country_id' : country_id,
      'city_id' : city_id,
      'name' : name
    };
  }
}