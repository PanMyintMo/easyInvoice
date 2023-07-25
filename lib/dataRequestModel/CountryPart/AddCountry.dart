class AddCountry{
  final String name;
  AddCountry({required this.name});

  Map<String,dynamic> toJson() {
    return {
      'name' : name
    };
}
}