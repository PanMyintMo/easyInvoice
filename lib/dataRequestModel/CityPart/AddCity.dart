class AddCity{
  final String country_id;
  final String name;

  AddCity({required this.country_id, required this.name});

  Map<String,dynamic> toJson() {
    return {
      'country_id' : country_id,
      'name' : name
    };
  }
}