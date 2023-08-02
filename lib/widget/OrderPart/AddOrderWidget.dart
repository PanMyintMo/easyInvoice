import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:flutter/material.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/Cities.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/GetAllProductResponse.dart';
import '../../data/responsemodel/TownshipsPart/AllTownshipResponse.dart';

class AddOrderWidget extends StatefulWidget {
  final bool isLoading;

  const AddOrderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String payment = ''; // no radio button will be selected on initial
  String? select_product;
  List<ProductListItem> products = [];
  List<Country> countries = [];
  String? select_country;
  List<City> cities = [];
  String? select_city;
  List<Township> townships = [];
  String? select_township;

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController line1 = TextEditingController();
  final TextEditingController line2 = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController sale_price = TextEditingController();
  final TextEditingController available_quantity = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController total = TextEditingController();

  bool checkboxValue = false;

  @override
  void initState() {
    super.initState();
    fetchProductListItem();
    fetchCountyName();
    fetchCityName();
    fetchTownshipName();
  }

  void fetchProductListItem() async {
    final products = await ApiHelper.fetchAllProductItem();
    setState(() {
      this.products = products;
    });
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      this.countries = country;
    });
  }

  void fetchCityName() async {
    final city = await ApiHelper.fetchCityName();
    setState(() {
      this.cities = city;
    });
  }

  Future<void> fetchTownshipName() async {
    final township = await ApiHelper.fetchTownshipName();
    setState(() {
      this.townships = township;
    });
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    email.dispose();
    line1.dispose();
    line2.dispose();
    postcode.dispose();
    sale_price.dispose();
    available_quantity.dispose();
    quantity.dispose();
    total.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'All Order',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))),
              const SizedBox(height: 18.0),
              const Text(
                'Billing Address',
                style: TextStyle(fontSize: 18, color: Colors.pink),
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  buildProductContainerForm('First Name', TextInputType.name,
                      firstname, validateFirstName),
                  const SizedBox(width: 10.0),
                  buildProductContainerForm(
                    'Last Name',
                    TextInputType.name,
                    lastname,
                    validateLastName,
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: buildProductContainerForm(
                  'Phone no',
                  TextInputType.phone,
                  phone,
                  validateField,
                ),
              ),
              const SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: buildProductContainerForm(
                  'Email',
                  TextInputType.emailAddress,
                  email,
                  validateField,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  buildProductContainerForm(
                    'Line 1',
                    TextInputType.phone,
                    line1,
                    validateField,
                  ),
                  const SizedBox(width: 10.0),
                  buildProductContainerForm(
                    'Line 2',
                    TextInputType.number,
                    line2,
                    validateField,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Country",
                style: TextStyle(fontSize: 18, color: Colors.pink),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: chooseItemIdForm(DropdownButton(
                  value: select_country,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Country Name'),
                    ),
                    ...countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.id.toString(),
                        child: Text(country.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_country = value;
                    });
                  },
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text("City",
                  style: TextStyle(fontSize: 18, color: Colors.pink)),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: chooseItemIdForm(DropdownButton(
                  value: select_city,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select City Name'),
                    ),
                    ...cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city.id.toString(),
                        child: Text(city.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_city = value;
                    });
                  },
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text("Township",
                  style: TextStyle(fontSize: 18, color: Colors.pink)),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: chooseItemIdForm(DropdownButton(
                  value: select_township,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Township Name'),
                    ),
                    ...townships.map((township) {
                      return DropdownMenuItem<String>(
                        value: township.id.toString(),
                        child: Text(township.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_township = value;
                    });
                  },
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: buildProductContainerForm(
                  'Postcode',
                  TextInputType.number,
                  postcode,
                  validateField,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Checkbox(
                    value: checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        checkboxValue = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Ship to a different address?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text("Product Name",
                  style: TextStyle(fontSize: 18, color: Colors.pink)),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: chooseItemIdForm(DropdownButton(
                  value: select_product,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Product Name'),
                    ),
                    ...products.map((product) {
                      return DropdownMenuItem<String>(
                        value: product.id.toString(),
                        child: Text(product.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      select_product = value;
                    });
                  },
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  buildProductContainerForm(
                    'Sale Price',
                    TextInputType.number,
                    sale_price,
                    validateField,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  buildProductContainerForm(
                    'Available quantity',
                    TextInputType.number,
                    available_quantity,
                    validateField,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  buildProductContainerForm(
                    'Quantity',
                    TextInputType.number,
                    quantity,
                    validateField,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  buildProductContainerForm(
                    'Total',
                    TextInputType.number,
                    total,
                    validateField,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, color: Colors.pink),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Cash'),
                      activeColor: Colors.pink,
                      value: "Cash On Delivery",
                      dense: true,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('KPay'),
                      value: "Kpay",
                      dense: true,
                      activeColor: Colors.pink,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('WavePay'),
                      value: "Wave pay",
                      dense: true,
                      activeColor: Colors.pink,
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value as String;
                        });
                      },
                    ),
                  )
                ],
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {

                  if(_formKey.currentState!.validate()){



                  }




                      }, child: const Text('Place Order Now')))
            ],
          ),
        ),
      ),
    );
  }
}
