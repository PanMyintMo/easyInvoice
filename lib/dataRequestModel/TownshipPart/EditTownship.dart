class EditTownship{
  final String city_id;
  final String name;

  EditTownship({required this.city_id, required this.name});

  Map<String,dynamic> toJson() {
    return {
      'name' : name,
      'city_id' : city_id
    };
  }

}