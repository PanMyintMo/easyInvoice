import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/EditOrderDetailRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/edit/CityPart/edit_order_detail_cubit.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/api/ConnectivityService.dart';
import '../../data/responseModel/CityPart/FetchCityByCountryId.dart';
import '../../data/responseModel/CityPart/Street.dart';
import '../../data/responseModel/CityPart/WardByTownshipResponse.dart';
import '../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../data/responseModel/DeliveryPart/DeliCompanyNameByTownshipId.dart';
import '../../data/responseModel/MainPagePart/MainPageResponse.dart';
import '../../data/responseModel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../../data/responseModel/common/ProductListItemResponse.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderProductQty.dart';
import '../../network/SharedPreferenceHelper.dart';

class EditOrderWidget extends StatefulWidget {
  final bool isLoading;
  final OrderDatas orderDetailResponse;

  const EditOrderWidget({
    super.key,
    required this.isLoading,
    required this.orderDetailResponse,
  });

  @override
  State<EditOrderWidget> createState() => _EditOrderWidgetState();
}

class _EditOrderWidgetState extends State<EditOrderWidget> {
  List<Country> countries = [];
  List<CityByCountryIdData> cities = [];
  List<TownshipByCityIdData> townships = [];
  List<WardByTownshipData> wards = [];
  List<ProductListItem> products = [];
  List<Street> streets = [];

  List<CompanyData> companyData = [];
  String? selectedCountryId; // Use the country ID for initial selection
  String? selectedCityId; // Use the country ID for initial selection
  String? selectStreetId; // Use the country ID for initial selection
  String? selectedTownshipId; // Use the country ID for initial selection
  String? selectWardId; // Use the country ID for initial selection
  String? selectDeliveryCompanyId;
  String? selectedProductId;

  String waitingTime = '';
  int basicCost = 0;
  int? totalQty;
  String? message = '';

  String? errorText = '';
  int? available_quantity = 0;

  String cname = '';
  bool isVisible = false;
  String url = '';
  int? userId;

  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();
  var line1 = TextEditingController();
  var line2 = TextEditingController();
  var zipcode = TextEditingController();
  var description = TextEditingController();
  var sale_price = TextEditingController();

  var quantity = TextEditingController();

  var block_no = TextEditingController();
  var floor = TextEditingController();

  String? transactionId;

  @override
  void initState() {
    super.initState();
    fetchAllCountryName();
    fetchAllProductName();
    fetchLoginUserId();

    transactionId = widget.orderDetailResponse.transaction_mode.toString();

    selectDeliveryCompanyId = widget.orderDetailResponse.company_id.toString();
    firstname =
        TextEditingController(text: widget.orderDetailResponse.firstname);
    lastname = TextEditingController(text: widget.orderDetailResponse.lastname);
    mobile = TextEditingController(text: widget.orderDetailResponse.mobile);
    email = TextEditingController(text: widget.orderDetailResponse.email);
    line1 = TextEditingController(text: widget.orderDetailResponse.line1);
    line2 = TextEditingController(text: widget.orderDetailResponse.line2);
    zipcode = TextEditingController(text: widget.orderDetailResponse.zipcode);
    description = TextEditingController(
        text: widget.orderDetailResponse.short_description);
    sale_price = TextEditingController(
        text: widget.orderDetailResponse.sale_price.toString());
    available_quantity = widget.orderDetailResponse.shop_product.quantity;

    quantity = TextEditingController(
        text: widget.orderDetailResponse.quantity.toString());
    totalQty = widget.orderDetailResponse.total;
    block_no = TextEditingController(text: widget.orderDetailResponse.block_no);
    floor = TextEditingController(text: widget.orderDetailResponse.floor);
  }

  // Retrieve the user type from shared preferences
  Future<void> fetchLoginUserId() async {
    final sessionManager = SessionManager();
    userId = await sessionManager.getLoginUserId();
    setState(() {
      userId = userId;
    });
  }

  void fetchAllProductName() async {
    final response = await ApiHelper.fetchAllProductItem();
    products = response!;
    if (response.isNotEmpty) {
      final matchingProduct = products.firstWhere(
              (product) => product.id == widget.orderDetailResponse.product_id);

      selectedProductId = matchingProduct.id.toString();
    }
  }

  void fetchAllCountryName() async {
    final fetchedCountries = await ApiHelper.fetchCountryName();
    setState(() {
      countries = fetchedCountries ?? [];
      if (fetchedCountries!.isNotEmpty) {
        selectedCountryId = widget.orderDetailResponse.country_id.toString();
      }
      fetchCitiesByCountryId(int.parse(selectedCountryId!));
    });
  }

  void fetchCitiesByCountryId(int id) async {
    final fetchCities = await ApiService(ConnectivityService()).fetchAllCitiesByCountryId(id);
    cities = fetchCities;

    if (cities.isNotEmpty) {
      final matchingCity = cities.firstWhere(
            (city) => city.id == widget.orderDetailResponse.city_id,
      );
      selectedCityId = matchingCity.id.toString();
    }
    setState(() {
      selectedCityId = selectedCityId;
      fetchTownshipByCityId(int.parse(selectedCityId!));
    });
  }

  void fetchTownshipByCityId(int id) async {
    final fetchTownship = await ApiService(ConnectivityService()).fetchAllTownshipByCityId(id);
    townships = fetchTownship;

    if (townships.isNotEmpty) {
      final matchingTownship = townships.firstWhere(
            (township) => township.id == widget.orderDetailResponse.township_id,
      );
      selectedTownshipId = matchingTownship.id.toString();
    }
    setState(() {
      selectedTownshipId = selectedTownshipId;
    });
    fetchWardByTownshipId(int.parse(selectedTownshipId!));
    fetchDeliCompanyNameByTownshipId(int.parse(selectedTownshipId!));
  }

  void fetchDeliCompanyNameByTownshipId(int id) async {
    final response = await ApiService(ConnectivityService()).fetchAllCompanyByTownshipId(id);
    companyData = response;
    if (response.isNotEmpty) {
      final matchingDeliveryCompany = response.firstWhere(
              (company) => company.id == widget.orderDetailResponse.company_id);

      selectDeliveryCompanyId = matchingDeliveryCompany.id.toString();
      setState(() {
        selectDeliveryCompanyId = selectDeliveryCompanyId;
      });
    }
  }

  void fetchWardByTownshipId(int id) async {
    final response = await ApiHelper.fetchWardByTownshipId(id);
    wards = response;

    setState(() {
      if (response.isNotEmpty) {
        final matchingWard = wards.firstWhere(
                (ward) => ward.id == widget.orderDetailResponse.ward_id);

        selectWardId = matchingWard.id.toString();
        selectWardId = selectWardId;
        fetchStreetByWardId(int.parse(selectWardId!));
      }
    });
  }


  void fetchStreetByWardId(int id) async {
    streets = await ApiHelper.fetchStreetByWardId(id);

    if (streets.isNotEmpty) {
      final matchingStreet = streets.firstWhere(
              (street) => street.id == widget.orderDetailResponse.street_id);
      selectStreetId = matchingStreet.id.toString();
      setState(() {
        selectStreetId = selectStreetId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Billing Address',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        flex :1,
                        child: buildProductContainerForm(
                            widget.orderDetailResponse.firstname.toString(),
                            TextInputType.name,
                            firstname,
                            validateField),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          "Last name",
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
                      "phone",
                      TextInputType.phone,
                      mobile,
                      validateField,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          "Line",
                          TextInputType.phone,
                          line1,
                          validateField,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: buildProductContainerForm(
                          "Line",
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
                      "email",
                      TextInputType.emailAddress,
                      email,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),


                  const Text(
                    "Country",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: selectedCountryId,
                      items: countries.map((country) {
                        return DropdownMenuItem(
                          value: country.id.toString(),
                          child: Text(country.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountryId = value!;
                          selectedCityId = null;
                          fetchCitiesByCountryId(int.parse(selectedCountryId!));
                        });
                      },
                      hint: "Select Country", context: context,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("City",
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: selectedCityId,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city.id.toString(),
                          child: Text(city.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCityId = value!;
                          selectedTownshipId = null;

                          fetchTownshipByCityId(int.parse(selectedCityId!));
                        });
                      },
                      hint: "Select City", context: context,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Township",
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: selectedTownshipId,
                      items: townships.map((township) {
                        return DropdownMenuItem(
                          value: township.id.toString(),
                          child: Text(township.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTownshipId = value!;
                          fetchWardByTownshipId(int.parse(selectedTownshipId!));
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
                      value: selectWardId,
                      items: wards.map((ward) {
                        return DropdownMenuItem(
                          value: ward.id.toString(),
                          child: Text(ward.ward_name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectWardId = value!;
                          fetchStreetByWardId(int.parse(selectWardId!));
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
                      value: selectStreetId,
                      items: streets.map((street) {
                        return DropdownMenuItem(
                          value: street.id.toString(),
                          child: Text(street.street_name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectStreetId = value!;
                          fetchStreetByWardId(int.parse(selectStreetId!));
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
                      "block",
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
                      widget.orderDetailResponse.floor,
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
                      "zip",
                      TextInputType.text,
                      zipcode,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildProductContainerForm(
                      "desc",
                      TextInputType.text,
                      description,
                      validateField,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Choose Delivery service :',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: companyData.length,
                    itemBuilder: (context, index) {
                      var companyName = companyData[index].company_type.name;
                      var id = companyData[index].company_id;
                      return RadioListTile(
                        dense: true,
                        activeColor: Colors.blue,
                        title: Text(
                          "Service : $companyName",
                          style: const TextStyle(color: Colors.black),
                        ),
                        value: selectDeliveryCompanyId,
                        groupValue: selectDeliveryCompanyId,
                        onChanged: (value) {
                          setState(() {
                            selectDeliveryCompanyId = value;
                            if (companyData[index].company_id == id) {
                              isVisible = true;
                              waitingTime = companyData[index].waiting_time;
                              basicCost = companyData[index].basic_cost;
                              url = companyData[index].company_type.url;
                              cname = companyName;
                            } else {
                              isVisible =
                              false; // Hide the details if no service is selected
                            }
                          });
                        },
                      );
                    },
                  ),
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
                          "Waiting time is: $waitingTime",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Basic Cost is: $basicCost",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Company Name is: $cname",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Product Name",
                      style: TextStyle(fontSize: 18, color: Colors.blue)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: buildDropdown(
                      value: selectedProductId,
                      items: products.map((product) {
                        return DropdownMenuItem(
                          value: product.id.toString(),
                          child: Text(product.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProductId = value!;
                        });
                      },
                      hint: "Select Product", context: context,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Sale Price"),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerForm(
                    "Price",
                    TextInputType.number,
                    sale_price,
                    validateField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildProductContainerText("Available Quantity"),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 0.3),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text("$available_quantity"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Quantity",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: quantity,
                      onChanged: (val) async {
                        if (val.isNotEmpty) {
                          int enteredQuantity = int.tryParse(val) ?? 0;

                          if (enteredQuantity > available_quantity!) {
                            setState(() {
                              totalQty = 0;
                              errorText =
                              'Quality can not be greater than available quantity!';
                            });
                          } else {
                            final response = await ApiService(ConnectivityService())
                                .changeOrderQty(ChangeOrderProductQtyRequest(
                              selectedProductId: selectedProductId.toString(),
                              quantity: val.toString(),
                              sale_price: sale_price.toString(),
                            ));

                            setState(() {
                              available_quantity = response.available_quantity;
                              totalQty = response.total;
                              errorText = null;
                            });
                          }
                        }

                        else {
                          final response = await ApiService(ConnectivityService())
                              .changeOrderQty(
                              ChangeOrderProductQtyRequest(
                                selectedProductId: selectedProductId.toString(),
                                quantity: val.toString(),
                                sale_price: sale_price.toString(),
                              )
                          );
                          setState(() {
                            available_quantity = response.available_quantity;
                            totalQty = response.total;
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

                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: Colors.black54, width: 0.3),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text("$totalQty"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('Cash'),
                          activeColor: transactionId == "cod"
                              ? Colors.blue
                              : Colors.black,
                          value: "cod",
                          dense: true,
                          groupValue: transactionId,
                          onChanged: (value) {
                            setState(() {
                              transactionId = value as String;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('KPay'),
                          value: "kpay",
                          dense: true,
                          activeColor: transactionId == "kpay"
                              ? Colors.blue
                              : Colors.black,
                          groupValue: transactionId,
                          onChanged: (value) {
                            setState(() {
                              transactionId = value as String;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('WavePay'),
                          value: "wavepay",
                          dense: true,
                          activeColor: transactionId == "wavepay"
                              ? Colors.blue
                              : Colors.black,
                          groupValue: transactionId,
                          onChanged: (value) {
                            setState(() {
                              transactionId = value as String;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 18),
                  Center(
                      child: ElevatedButton(
                        style: ThemeHelperUserRole().buttonStyle(),
                        onPressed: () {
                          context.read<EditOrderDetailCubit>()
                              .updateOrderDetail(
                              widget.orderDetailResponse.order_id,
                              EditOrderDetailRequestModel(
                                  firstname: firstname.text.toString(),
                                  lastname: lastname.text.toString(),
                                  email: email.text.toString(),
                                  line1: line1.text.toString(),
                                  line2: line2.text.toString(),
                                  selectedCountry: selectedCountryId.toString(),
                                  selectedCity: selectedCityId.toString(),
                                  selectedTownship: selectedTownshipId
                                      .toString(),
                                  selectedStreet: selectStreetId.toString(),
                                  selectedWard: selectWardId.toString(),
                                  quantity: quantity.text.toString(),
                                  block_no: block_no.text.toString(),
                                  product_id: selectedProductId.toString(),
                                  zipcode: zipcode.text.toString(),
                                  mobile: mobile.text.toString(),
                                  user_sign: '',
                                  floor: floor.text.toString(),
                                  price: sale_price.text.toString(),
                                  user_id: userId.toString(),
                                  delivery: selectDeliveryCompanyId.toString(),
                                  mode: transactionId.toString()));
                        },
                        child: const Text("Update Order"),
                      ))
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
