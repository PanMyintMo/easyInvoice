class EditCountry{
  final String name;

  EditCountry({required this.name});
  Map<String,dynamic> toJson() {
    return {
      'name' : name
    };
  }
}