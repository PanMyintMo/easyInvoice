import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:flutter/material.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/DeliveryPart/DeliCompanyNameByTownshipId.dart';
import '../../data/responsemodel/GetAllProductResponse.dart';
import '../../data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';

class AddOrderWidget extends StatefulWidget {
  final bool isLoading;

  const AddOrderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String payment = ''; // no radio button will be selected on initial
  int serviceId = 0;
  String? select_product;
  List<ProductListItem> products = [];
  List<CompanyData> companyData = [];
  List<Country> countries = [];
  String? select_country;
  List<String> companyName = [];

  String? select_city;
  late String city_id;
  late String township_id;

  List<int>? companyId = [];

  String? select_township;
  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];

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

  bool hasCitiesForSelectedCountry = true;
  bool hasTownshipForSelectedCity = true;

  @override
  void initState() {
    super.initState();
    fetchProductListItem();
    fetchCountyName();
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
      countries = country;
    });
  }

  void fetchCitiesByCountryId(int id) async {
    try {
      final response = await ApiService().fetchAllCitiesByCountryId(id);
      setState(() {
        cities = response;
        if (response.isNotEmpty) {
          city_id = 'Select City'; // Reset city_id to default 'Select City'
          hasCitiesForSelectedCountry = true;
        } else {
          hasCitiesForSelectedCountry = false;
        }
      });
    } catch (e) {
      setState(() {
        cities = [];
        hasCitiesForSelectedCountry = false;
      });
    }
  }

  void fetchTownshipByCityId(int id) async {
    try {
      final response = await ApiService().fetchAllTownshipByCityId(id);
      setState(() {
        townships = response;
        if (response.isNotEmpty) {
          township_id =
              'Select Township'; // Reset city_id to default 'Select City'
          hasTownshipForSelectedCity = true;
        } else {
          hasTownshipForSelectedCity = false;
        }
      });
    } catch (e) {
      setState(() {
        townships = [];
        hasTownshipForSelectedCity = false;
      });
    }
  }

  void fetchDeliCompanyNameByTownshipId(int id) async {
    final response = await ApiService().fetchAllCompanyByTownshipId(id);
    setState(() {
      companyData = response;
      if (response.isNotEmpty) {
        companyData = companyData.map((x) => x).toList();
      }
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
                      firstname, validateField),
                  const SizedBox(width: 10.0),
                  buildProductContainerForm(
                    'Last Name',
                    TextInputType.name,
                    lastname,
                    validateField,
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
                      int countryId = int.parse(value!);
                      fetchCitiesByCountryId(countryId);
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
                  value: hasCitiesForSelectedCountry ? select_city : null,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select City Name'),
                    ),
                    if (hasCitiesForSelectedCountry)
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
                      int cityId = int.parse(value!);
                      fetchTownshipByCityId(cityId);
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
                  value: hasTownshipForSelectedCity ? select_township : null,
                  items: [
                    const DropdownMenuItem(
                      value: null, // Set initial value to null
                      child: Text('Select Township Name'),
                    ),
                    if (hasTownshipForSelectedCity)
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
                      int townshipId = int.parse(value!);
                      fetchDeliCompanyNameByTownshipId(townshipId);
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (select_township != null)
                    const Text(
                      'Choose Delivery service',
                      style: TextStyle(color: Colors.black),
                    ),
                  const SizedBox(
                    height: 18,
                  ),
                  if (select_township != null && companyData.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: companyData.length,
                        itemBuilder: (context, index) {
                          var companyName = companyData[index].companyType.name;
                          var id = companyData[index].companyType.id;

                          return RadioListTile(
                              dense: true,
                              activeColor: Colors.pink,
                              title: Text(
                                "Service :$companyName",
                                style: const TextStyle(color: Colors.black),
                              ),
                              value: id,
                              groupValue: serviceId,
                              onChanged: (value) {
                                setState(() {
                                  serviceId= value as int;

                                  if(companyData[index].companyId== companyData[index].companyType.id){
                                    var waitingTime = companyData[index].waitingTime;

                                    print("Waiting Time is: $waitingTime");
                                  }

                                });
                              });
                        })
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
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text('Place Order Now')))
            ],
          ),
        ),
      ),
    );
  }
}
