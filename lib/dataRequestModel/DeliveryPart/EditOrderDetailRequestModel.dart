class EditOrderDetailRequestModel {
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
  final String product_id;
  final String price;
  final String quantity;
  final String? user_sign;
  final String user_id;

  EditOrderDetailRequestModel(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.line1,
      required this.line2,
      required this.selectedCountry,
      required this.selectedCity,
      required this.selectedTownship,
      required this.selectedStreet,
      required this.selectedWard,
      required this.quantity,
        required this.user_sign,
      required this.block_no,
      required this.product_id,
      required this.zipcode,
      required this.mobile,
      required this.floor,
      required this.price,
      required this.user_id,
      required this.delivery,
      required this.mode});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'line1': line1,
      'line2': line2,
      'selectedCountry': selectedCountry,
      'selectedCity': selectedCity,
      'selectedTownship': selectedTownship,
      'selectedStreet': selectedStreet,
      'selectedWard': selectedWard,
      'quantity': quantity,
      'block_no': block_no,
      'product_id': product_id,
      'zipcode': zipcode,
      'mobile': mobile,
      'floor': floor,
      'price': price,
      'user_id': user_id,
      'user_sign': user_sign,
      'delivery': delivery,
      'mode': mode
    };
  }
}
