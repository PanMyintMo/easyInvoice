class AddOrderRequestModel {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String line1;
  final String line2;
  final String selectedCountry;
  final String selectedCity;
  final String selectedTownship;
  final String selectedWard;
  final String selectedStreet;
  final String block_no;
  final String floor;
  final String zipcode;
  final String mode;
  final String delivery;
  final String user_sign;
  final String product_id;
  final String price;
  final String quantity;
  final String user_id;

  AddOrderRequestModel(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.mobile,
      required this.line1,
      required this.line2,
      required this.selectedCountry,
      required this.selectedTownship,
      required this.selectedCity,
      required this.selectedWard,
      required this.selectedStreet,
      required this.block_no,
      required this.floor,
      required this.zipcode,
      required this.mode,
      required this.delivery,
      required this.user_sign,
      required this.product_id,
      required this.price,
      required this.quantity,
      required this.user_id});

  Map<String,dynamic> toJson() {
    return {
      'firstname' : firstname,
      'lastname' : lastname,
      'email' : email,
      'mobile' : mobile,
      'line1' : line1,
      'line2' : line2,
      'selectedCountry' : selectedCountry,
      'selectedTownship' : selectedTownship,
      'selectedCity' : selectedCity,
      'selectedWard' : selectedWard,
      'selectedStreet' : selectedStreet,
      'block_no' : block_no,
      'floor' : floor,
      'zipcode' : zipcode,
      'mode' : mode,
      'delivery' : delivery,
      'user_sign' : user_sign,
      'product_id' : product_id,
      'price' : price,
      'quantity' : quantity,
      'user_id' : user_id

    };
  }
}
