import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/DeliveryPart/add_order_cubit.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CityPart/Street.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/DeliveryPart/DeliCompanyNameByTownshipId.dart';
import '../../data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../data/responsemodel/common/ProductListItemResponse.dart';
import '../../data/responsemodel/common/WardResponse.dart';
import '../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderProductQty.dart';
import '../../dataRequestModel/DeliveryPart/ChooseProductForOrderRequestModel.dart';
import '../../network/SharedPreferenceHelper.dart';

class AddOrderWidget extends StatefulWidget {
  final bool isLoading;

  const AddOrderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String payment = ''; // no radio button will be selected on initial
  int serviceId = 0;
  int? userId;
  String? select_product;
  List<ProductListItem> products = [];
  List<CompanyData> companyData = [];
  List<Country> countries = [];
  String? select_country;
  String url = '';
  String product_id = '';
  String cname = '';
  String selectedProductId = '';
  double? salePrice = 0.0;
  int? productQuality = 0;
  String? select_township;
  String? select_ward;
  List<String> companyName = [];
  String? select_city;
  String? select_street;
  late String city_id;
  late String township_id;
  String? ward_id;
  late String street_id;
  String waitingTime = '';
  double basicCost = 0;
  List<int>? companyId = [];
  int totalQty = 0;
  String? message = '';
  String? errorText = '';

  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];
  List<Ward> wards = [];
  List<Street> streets = [];

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController line1 = TextEditingController();
  final TextEditingController line2 = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final TextEditingController sale_price = TextEditingController();
  final TextEditingController available_quantity = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController block_no = TextEditingController();
  final TextEditingController floor = TextEditingController();


  bool hasCitiesForSelectedCountry = true;
  bool hasTownshipForSelectedCity = true;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    fetchProductListItem();
    fetchCountyName();
    fetchLoginUserId();
  }

  // Retrieve the user type from shared preferences
  Future<void> fetchLoginUserId() async {
    final sessionManager = SessionManager();
    userId = await sessionManager.getLoginUserId();
    setState(() {
      userId = userId;
    });
  }

  void fetchProductListItem() async {
    final products = await ApiHelper.fetchAllProductItem();
    setState(() {
      this.products = products!;
    });
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      countries = country!;
    });
  }

  void chooseProductOrderById(ChooseProductOrderRequest? id) async {
    try {
      final response = await ApiService().chooseProductOrder(id!);
      setState(() {
        productQuality = response.available_quantity;
        salePrice = response.sale_price;
      });
    } catch (e) {
      print("$e");
    }
  }

  void changeOrderQty(ChangeOrderProductQtyRequest orderProductRequest) async {
    try {
      final response = await ApiService().changeOrderQty(orderProductRequest);
      setState(() {
        productQuality = response.availableQuantity;
        totalQty = response.total;
        message = response.message;
      });
    } catch (e) {
     // print("Change order error is $e");
    }
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

  void fetchWardByTownshipId(int id) async {
    final response = await ApiHelper.fetchWardByTownshipId(id);
    setState(() {
      wards = response;
      if (response.isNotEmpty) {
        ward_id = null; // Reset ward_id to default 'Select Ward'
      }
    });
  }

  void fetchStreetByWardId(int id) async {
    final response = await ApiHelper.fetchStreetByWardId(id);
    setState(() {
      streets = response;
      if (response.isNotEmpty) {
        street_id = 'Select Street'; // Reset street_id to default 'Select City'
      }
    });
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
    mobile.dispose();
    email.dispose();
    line1.dispose();
    line2.dispose();
    zipcode.dispose();
    sale_price.dispose();
    available_quantity.dispose();
    quantity.dispose();
    total.dispose();
    block_no.dispose();
    floor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
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
                      mobile,
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
                        TextInputType.phone,
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
                      hint:const Text("Select Country"),
                      value: select_country,
                      items: [
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
                      hint: const Text("Select City Name"),
                      value: hasCitiesForSelectedCountry ? select_city : null,
                      items: [
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
                      hint: const Text("Select Township"),
                      value: hasTownshipForSelectedCity ? select_township : null,
                      items: [
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
                          fetchWardByTownshipId(townshipId);
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
                    child: chooseItemIdForm(DropdownButton(
                      hint: const Text("Select Ward"),
                      value: select_ward,
                      items: [
                        ...wards.map((ward) {
                          return DropdownMenuItem(
                            value: ward.id.toString(),
                            child: Text(ward.ward_name),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          select_ward = value;
                          int wardId = int.parse(value!);
                          fetchStreetByWardId(wardId);
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
                    child: chooseItemIdForm(DropdownButton(
                      hint: const Text("Select Street"),
                      value: select_street,
                      items: [
                        ...streets.map((street) {
                          return DropdownMenuItem<String>(
                            value: street.id.toString(),
                            child: Text(street.street_name),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          select_street = value;
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
                      'Block Number',
                      TextInputType.text,
                      block_no,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      'Floor',
                      TextInputType.text,
                      floor,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      'Zip code',
                      TextInputType.text,
                      zipcode,
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
                      const Text(
                        'Choose Delivery service :',
                        style: TextStyle(color: Colors.pink, fontSize: 18),
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
                                      serviceId = value as int;
                                      if (companyData[index].companyId ==
                                          companyData[index].companyType.id) {
                                        isVisible = true;
                                        waitingTime =
                                            companyData[index].waitingTime;
                                        basicCost = companyData[index].basicCost;
                                        url = companyData[index].companyType.url;
                                        cname = companyData[index].companyType.name;
                                      } else {
                                        url = '';
                                      }
                                    });
                                  });
                            }),
                      const SizedBox(
                        height: 18,
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Waiting time is : $waitingTime",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Basic Cost is : $basicCost",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Company Name is : $cname",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            if (url.isNotEmpty)
                              Image.network(
                                url,
                                width: double.infinity,
                                height: 150,
                              )
                          ],
                        ),
                      )
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
                      hint: const Text("Select Product"),
                      value: select_product,
                      items: [
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
                          product_id =
                              select_product!; // Assign selected value to product_id
                          chooseProductOrderById(
                              ChooseProductOrderRequest(product_id: product_id));
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
                      buildProductContainerText("Sale Price"),
                      buildProductContainerText("Available Quantity"),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("$salePrice"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("$productQuality"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: quantity,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              int enteredQuantity = int.tryParse(val) ?? 0;
                              if (enteredQuantity > productQuality!) {
                                setState(() {
                                  totalQty = 0;
                                  errorText =
                                      'Quality can not be greater than available quantity!';
                                });
                              } else {
                                setState(() {
                                  totalQty = 0;
                                  errorText = null;
                                });
                                changeOrderQty(
                                    ChangeOrderProductQtyRequest(
                                  selectedProductId: product_id,
                                  selectedProductQuantity:
                                      productQuality.toString(),
                                  quantity: val.toString(),
                                  sale_price: salePrice.toString(),
                                ));
                              }
                            } else {
                              setState(() {
                                totalQty = 0;
                                errorText = null;
                                changeOrderQty(ChangeOrderProductQtyRequest(
                                  selectedProductId: product_id,
                                  selectedProductQuantity:
                                      productQuality.toString(),
                                  quantity: val.toString(),
                                  sale_price: salePrice.toString(),
                                ));
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          validator: validateField,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            errorText: errorText, // Display the error message
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("$totalQty"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, color: Colors.black),
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
                          value: "cod",
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
                          value: "wavepay",
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
                  const SizedBox(height: 18),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                            context.read<AddOrderCubit>().addOrder(
                                AddOrderRequestModel(
                                    firstname: firstname.text.toString(),
                                    lastname: lastname.text.toString(),
                                    email: email.text.toString(),
                                    mobile: mobile.text.toString(),
                                    line1: line1.text.toString(),
                                    line2: line2.text.toString(),
                                    selectedCountry: select_country.toString(),
                                    selectedTownship: select_township.toString(),
                                    selectedCity: select_city.toString(),
                                    zipcode: zipcode.text.toString(),
                                    mode: payment.toString(),
                                    delivery: serviceId.toString(),
                                    user_sign: '',
                                    product_id: product_id.toString(),
                                    price: salePrice.toString(),
                                    quantity: quantity.text.toString(),
                                    user_id: userId.toString(),
                                    selectedWard: select_ward.toString(),
                                    selectedStreet: select_street.toString(),
                                    block_no: block_no.text.toString(),
                                    floor: floor.text.toString()));
                          },
                          child: const Text('Place Order Now')))
                ],
              ),
            ),
          ),
        ),
        if(widget.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),

      ],
    );
  }
}
