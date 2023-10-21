import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responseModel/CityPart/WardByTownshipResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post/DeliveryPart/add_order_cubit.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/responseModel/CityPart/FetchCityByCountryId.dart';
import '../../data/responseModel/CityPart/Street.dart';
import '../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../data/responseModel/DeliveryPart/DeliCompanyNameByTownshipId.dart';
import '../../data/responseModel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';
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
  List<ShopProductItem> products = [];
  List<CompanyData> companyData = [];
  List<Country> countries = [];
  String? select_country;
  String url = '';
  String product_id = '';
  String cname = '';
  String selectedProductId = '';
  String salePrice = '0';
  int? productQuality = 0;
  String? select_township;
  String? select_ward;
  List<String> companyName = [];
  String? select_city;
  String? select_street;


  String waitingTime = '';
  int basicCost = 0;
  List<int>? companyId = [];
  int totalQty = 0;
  String? message = '';
  String? errorText = '';

  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];
  List<WardByTownshipData> wards = [];
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
    final response = await ApiHelper.allShopProduct();
    setState(() {
      products = response!.data.data;
    });
  }

  void fetchCountyName() async {
    final country = await ApiHelper.fetchCountryName();
    setState(() {
      countries = country!;
    });
  }

  void chooseProductOrderById(ChooseProductOrderRequest? id) async {
    final response = await ApiService(ConnectivityService()).chooseProductOrder(id!);
    setState(() {
      productQuality = response.available_quantity;
      salePrice = response.sale_price;
    });
  }



  void fetchCitiesByCountryId(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllCitiesByCountryId(id);
    setState(() {
      cities = response;
      if (response.isNotEmpty) {}
    });
  }

  void fetchTownshipByCityId(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllTownshipByCityId(id);
    setState(() {
      townships = response;
      if (response.isNotEmpty) {

      }
    });
  }

  void fetchWardByTownshipId(int id) async {
    final response = await ApiHelper.fetchWardByTownshipId(id);

    setState(() {
      wards = response;
      if (response.isNotEmpty) {

      }
    });
  }

  void fetchStreetByWardId(int id) async {
    final response = await ApiHelper.fetchStreetByWardId(id);
    setState(() {
      streets = response;
      if (response.isNotEmpty) {}
    });
  }

  void fetchDeliCompanyNameByTownshipId(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllCompanyByTownshipId(id);
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
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
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
                  const SizedBox(height: 16.0),
                  const Text(
                    'Billing Address',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm('First Name',
                            TextInputType.name, firstname, validateField),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Last Name',
                          TextInputType.name,
                          lastname,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      'Phone no',
                      TextInputType.phone,
                      mobile,
                      validateField,
                    ),
                  ),


                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          'Line 1',
                          TextInputType.phone,
                          line1,
                          validateField,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(flex: 1,
                        child: buildProductContainerForm(
                          'Line 2',
                          TextInputType.phone,
                          line2,
                          validateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      'Email',
                      TextInputType.emailAddress,
                      email,
                      validateField,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Country",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_country,
                      items: countries.map((country) {
                        return DropdownMenuItem(
                            value: country.id.toString(),
                            child: Text(country.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_country = value;
                          select_township = null;
                          select_city = null;
                          int countryId = int.parse(value!);
                          fetchCitiesByCountryId(countryId);
                        });
                      },
                      hint: "Select Country Name", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  const Text("City",
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_city,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                            value: city.id.toString(),
                            child: Text(city.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_city = value;
                          select_township = null;
                          int cityId = int.parse(value!);
                          fetchTownshipByCityId(cityId);
                        });
                      },
                      hint: "Select City Name", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Township",
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_township,
                      items: townships.map((township) {
                        return DropdownMenuItem(
                            value: township.id.toString(),
                            child: Text(township.name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_township = value;
                          int townshipId = int.parse(value!);
                          fetchDeliCompanyNameByTownshipId(townshipId);
                          fetchWardByTownshipId(townshipId);
                        });
                      },
                      hint: "Select Township", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_ward,
                      items: wards.map((ward) {
                        return DropdownMenuItem(
                            value: ward.id.toString(),
                            child: Text(ward.ward_name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_ward = value;
                          int wardId = int.parse(value!);
                          fetchStreetByWardId(wardId);
                        });
                      },
                      hint: "Select Ward", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_street,
                      items: streets.map((street) {
                        return DropdownMenuItem(
                            value: street.id.toString(),
                            child: Text(street.street_name));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_street = value;
                        });
                      },
                      hint: "Select Street", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
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
                    height: 16,
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
                    height: 16,
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
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose Delivery service :',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (select_township != null && companyData.isNotEmpty)
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: companyData.length,
                            itemBuilder: (context, index) {
                              var companyName =
                                  companyData[index].company_type.name;
                              var id = companyData[index].company_id;

                              return RadioListTile(
                                  dense: true,
                                  activeColor: Colors.blue,
                                  title: Text(
                                    "Service :$companyName",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  value: id,
                                  groupValue: serviceId,
                                  onChanged: (value) {
                                    setState(() {
                                      serviceId = value as int;
                                      if (companyData[index].id ==
                                          companyData[index].id) {
                                        isVisible = true;
                                        waitingTime =
                                            companyData[index].waiting_time;
                                        basicCost =
                                            companyData[index].basic_cost;
                                        url =
                                            companyData[index].company_type.url;
                                        cname =
                                            companyData[index].company_type
                                                .name;
                                      } else {
                                        url = '';
                                      }
                                    });
                                  });
                            }),
                      const SizedBox(
                        height: 16,
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
                              height: 16,
                            ),
                            Text(
                              "Basic Cost is : $basicCost",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Company Name is : $cname",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
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
                    height: 16,
                  ),
                  const Text("Product Name",
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: select_product,
                      items: products.map((product) {
                        return DropdownMenuItem(
                            value: product.id.toString(),
                            child: Text(product.product_name.toString()
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          select_product = value;
                          product_id = select_product!;
                          // Assign selected value to product_id
                          chooseProductOrderById(ChooseProductOrderRequest(
                              product_id: product_id));
                        });
                      },
                      hint: "Select Product", context: context,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1,
                          child: buildProductContainerText("Sale Price",context)),
                      Expanded(flex: 1,
                          child: buildProductContainerText(
                              "Available Quantity",context)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
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
                            border:
                            Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text(salePrice),
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
                            border:
                            Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("$productQuality"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: quantity,
                          onChanged: (val) async {
                            if (val.isNotEmpty) {
                              int enteredQuantity = int.tryParse(val) ?? 0;
                              if (enteredQuantity > productQuality!) {
                                setState(() {
                                  totalQty = 0;
                                  errorText =
                                  'Quality can not be greater than available quantity!';
                                });
                              } else {
                                final response = await ApiService(ConnectivityService())
                                    .changeOrderQty(
                                    ChangeOrderProductQtyRequest(
                                      selectedProductId: product_id.toString(),
                                      quantity: val.toString(),
                                      sale_price: salePrice.toString(),
                                    )
                                );
                                setState(() {
                                  productQuality = response.available_quantity;
                                  totalQty = response.total!.toInt();
                                  errorText = null;
                                });
                              }
                            }
                            else {

                              final response = await ApiService(ConnectivityService())
                                  .changeOrderQty(
                                  ChangeOrderProductQtyRequest(
                                    selectedProductId: product_id.toString(),
                                    quantity: val.toString(),
                                    sale_price: salePrice.toString(),
                                  )
                              );
                              setState(() {
                                productQuality = response.available_quantity;
                                totalQty = response.total!.toInt();
                                errorText = null;
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          validator: validateField,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder( // Customize the error border here
                              borderSide: const BorderSide(
                                color: Colors.orange, // Change the color to your desired color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
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
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
                            border:
                            Border.all(color: Colors.black54, width: 0.3),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text("$totalQty"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Cash'),
                          activeColor: Colors.blue,
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
                          activeColor: Colors.blue,
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
                          activeColor: Colors.blue,
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
                  const SizedBox(height: 16),
                  Center(
                      child: ElevatedButton(
                          style: ThemeHelperUserRole().buttonStyle(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                            context.read<AddOrderCubit>().addOrder(
                                AddOrderRequestModel(
                                    firstname: firstname.text.toString(),
                                    lastname: lastname.text.toString(),
                                    email: email.text.toString(),
                                    mobile: mobile.text.toString(),
                                    line1: line1.text.toString(),
                                    line2: line2.text.toString(),
                                    selectedCountry: select_country.toString(),
                                    selectedTownship:
                                    select_township.toString(),
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
                          child: const Text('Place Order Now',style: TextStyle(fontWeight: FontWeight.bold),)))
                ],
              ),
            ),
          ),
        ),
        if (widget.isLoading)
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
