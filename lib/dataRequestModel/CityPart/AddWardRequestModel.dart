class AddWardRequestModel{
  final String state_id;
  final String ward_name;

  AddWardRequestModel({required this.state_id,required this.ward_name});

  Map<String,dynamic> toJson() {
    return {
      'state_id' : state_id,
      'ward_name' : ward_name
    };
  }
}