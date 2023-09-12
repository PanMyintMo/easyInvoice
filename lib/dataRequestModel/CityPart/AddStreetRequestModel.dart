class AddStreetRequestModel{
  final String ward_id;
  final String street_name;

  AddStreetRequestModel({required this.ward_id,required this.street_name});

  Map<String,dynamic> toJson() {
    return {
      'ward_id' : ward_id,
      'street_name' : street_name
    };
  }
}