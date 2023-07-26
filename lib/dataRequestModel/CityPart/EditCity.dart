class EditCity{
  final String country_id;
  final String name;

  EditCity({required this.country_id, required this.name});

  Map<String,dynamic> toJson() {
    return {
      'name' : name,
      'country_id' : country_id
    };
  }

}