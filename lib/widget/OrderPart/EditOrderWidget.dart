import 'package:easy_invoice/common/ApiHelper.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
import 'package:flutter/material.dart';
import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';
import '../../data/responsemodel/CityPart/FetchCityByCountryId.dart';
import '../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../data/responsemodel/MainPagePart/MainPageResponse.dart';

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
  String? selectedCountryId; // Use the country ID for initial selection
  String? selectedCityId; // Use the country ID for initial selection
  String? selectedTownshipId; // Use the country ID for initial selection

  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();
  var line1 = TextEditingController();
  var line2 = TextEditingController();
  var zipcode = TextEditingController();
  var sale_price = TextEditingController();
  var available_quantity = TextEditingController();
  var quantity = TextEditingController();
  var total = TextEditingController();
  var block_no = TextEditingController();
  var floor = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllCountryName();

    firstname =
        TextEditingController(text: widget.orderDetailResponse.firstname);
    lastname = TextEditingController(text: widget.orderDetailResponse.lastname);
    mobile = TextEditingController(text: widget.orderDetailResponse.mobile);
    email = TextEditingController(text: widget.orderDetailResponse.email);
    line1 = TextEditingController(text: widget.orderDetailResponse.line1);
    line2 = TextEditingController(text: widget.orderDetailResponse.line2);
    zipcode = TextEditingController(text: widget.orderDetailResponse.zipcode);
    sale_price =
        TextEditingController(text: widget.orderDetailResponse.sale_price);
    available_quantity = TextEditingController(
        text: widget.orderDetailResponse.quantity.toString());
    quantity = TextEditingController(
        text: widget.orderDetailResponse.quantity.toString());
    total = TextEditingController(
        text: widget.orderDetailResponse.total.toString());
    block_no = TextEditingController(text: widget.orderDetailResponse.block_no);
    floor = TextEditingController(text: widget.orderDetailResponse.floor);
  }

  void fetchAllCountryName() async {
    final fetchedCountries = await ApiHelper.fetchCountryName();
    setState(() {
      countries = fetchedCountries ?? [];
      if (fetchedCountries!.isNotEmpty) {
        selectedCountryId = widget.orderDetailResponse.country_id.toString();
      }
    });
    fetchCitiesByCountryId(int.parse(selectedCountryId!));
  }

  void fetchCitiesByCountryId(int id) async {
    final fetchCities = await ApiService().fetchAllCitiesByCountryId(id);
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
    final fetchTownship = await ApiService().fetchAllTownshipByCityId(id);
    townships = fetchTownship;

    if (townships.isNotEmpty) {
      final matchingTownship = townships.firstWhere(
            (township) => township.id == widget.orderDetailResponse.state_id,
      );
      selectedTownshipId = matchingTownship.id.toString();
    }
    setState(() {
      selectedTownshipId = selectedTownshipId;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Billing Address',
                  style: TextStyle(fontSize: 18, color: Colors.pink),
                ),
                const SizedBox(height: 18.0),
                Row(
                  children: [
                    buildProductContainerForm(
                        widget.orderDetailResponse.firstname.toString(),
                        TextInputType.name,
                        firstname,
                        validateField),
                    const SizedBox(width: 10.0),
                    buildProductContainerForm(
                      widget.orderDetailResponse.lastname,
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
                    widget.orderDetailResponse.mobile,
                    TextInputType.phone,
                    mobile,
                    validateField,
                  ),
                ),
                const SizedBox(height: 18.0),
                SizedBox(
                  width: double.infinity,
                  child: buildProductContainerForm(
                    widget.orderDetailResponse.email,
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
                      widget.orderDetailResponse.line1,
                      TextInputType.phone,
                      line1,
                      validateField,
                    ),
                    const SizedBox(width: 10.0),
                    buildProductContainerForm(
                      widget.orderDetailResponse.line2,
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
                    hint: const Text("Select Country"),
                    value: selectedCountryId,
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
                        selectedCountryId = value.toString();
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
                    value: selectedCityId,
                    items: [
                      ...cities.map((city) {
                        return DropdownMenuItem<String>(
                          value: city.id.toString(),
                          child: Text(city.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCityId = value;
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
                    value: selectedTownshipId,
                    items: [
                      ...townships.map((township) {
                        return DropdownMenuItem<String>(
                          value: township.id.toString(),
                          child: Text(township.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTownshipId = value;
                        // fetchDeliCompanyNameByTownshipId(townshipId);
                        //  fetchWardByTownshipId(townshipId);
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
                // SizedBox(
                //   width: double.infinity,
                //   child: chooseItemIdForm(DropdownButton(
                //     hint: const Text("Select Ward"),
                //     value: select_ward,
                //     items: [
                //       ...wards.map((ward) {
                //         return DropdownMenuItem(
                //           value: ward.id.toString(),
                //           child: Text(ward.ward_name),
                //         );
                //       }).toList(),
                //     ],
                //     onChanged: (value) {
                //       setState(() {
                //         select_ward = value;
                //         int wardId = int.parse(value!);
                //         fetchStreetByWardId(wardId);
                //       });
                //     },
                //     underline: const SizedBox(),
                //     borderRadius: BorderRadius.circular(10),
                //     icon: const Icon(Icons.arrow_drop_down),
                //     iconSize: 24,
                //     isExpanded: true,
                //     dropdownColor: Colors.white,
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //     ),
                //   )),
                // ),
                const SizedBox(
                  height: 18,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: chooseItemIdForm(DropdownButton(
                //     hint: const Text("Select Street"),
                //     value: select_street,
                //     items: [
                //       ...streets.map((street) {
                //         return DropdownMenuItem<String>(
                //           value: street.id.toString(),
                //           child: Text(street.street_name),
                //         );
                //       }).toList(),
                //     ],
                //     onChanged: (value) {
                //       setState(() {
                //         select_street = value;
                //       });
                //     },
                //     underline: const SizedBox(),
                //     borderRadius: BorderRadius.circular(10),
                //     icon: const Icon(Icons.arrow_drop_down),
                //     iconSize: 24,
                //     isExpanded: true,
                //     dropdownColor: Colors.white,
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //     ),
                //   )),
                // ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  child: buildProductContainerForm(
                    widget.orderDetailResponse.block_no,
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
                    widget.orderDetailResponse.floor,
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
                    widget.orderDetailResponse.zipcode,
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
                    // if (select_township != null && companyData.isNotEmpty)
                    //   ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: companyData.length,
                    //       itemBuilder: (context, index) {
                    //         var companyName = companyData[index].companyType.name;
                    //         var id = companyData[index].companyType.id;
                    //
                    //         return RadioListTile(
                    //             dense: true,
                    //             activeColor: Colors.pink,
                    //             title: Text(
                    //               "Service :$companyName",
                    //               style: const TextStyle(color: Colors.black),
                    //             ),
                    //             value: id,
                    //             groupValue: serviceId,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 serviceId = value as int;
                    //                 if (companyData[index].companyId ==
                    //                     companyData[index].companyType.id) {
                    //                   isVisible = true;
                    //                   waitingTime =
                    //                       companyData[index].waitingTime;
                    //                   basicCost = companyData[index].basicCost;
                    //                   url = companyData[index].companyType.url;
                    //                   cname = companyData[index].companyType.name;
                    //                 } else {
                    //                   url = '';
                    //                 }
                    //               });
                    //             });
                    //       }),
                    const SizedBox(
                      height: 18,
                    ),
                    // Visibility(
                    //   visible: isVisible,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Waiting time is : $waitingTime",
                    //         style: const TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.bold),
                    //       ),
                    //       const SizedBox(
                    //         height: 18,
                    //       ),
                    //       Text(
                    //         "Basic Cost is : $basicCost",
                    //         style: const TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.bold),
                    //       ),
                    //       const SizedBox(
                    //         height: 18,
                    //       ),
                    //       Text(
                    //         "Company Name is : $cname",
                    //         style: const TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.bold),
                    //       ),
                    //       const SizedBox(
                    //         height: 18,
                    //       ),
                    //       if (url.isNotEmpty)
                    //         Image.network(
                    //           url,
                    //           width: double.infinity,
                    //           height: 150,
                    //         )
                    //     ],
                    //   ),
                    // )
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
                // SizedBox(
                //   width: double.infinity,
                //   child: chooseItemIdForm(DropdownButton(
                //     hint: const Text("Select Product"),
                //     value: select_product,
                //     items: [
                //       ...products.map((product) {
                //         return DropdownMenuItem<String>(
                //           value: product.id.toString(),
                //           child: Text(product.name),
                //         );
                //       }).toList(),
                //     ],
                //     onChanged: (value) {
                //       setState(() {
                //         select_product = value;
                //         product_id =
                //         select_product!; // Assign selected value to product_id
                //         chooseProductOrderById(
                //             ChooseProductOrderRequest(product_id: product_id));
                //       });
                //     },
                //     underline: const SizedBox(),
                //     borderRadius: BorderRadius.circular(10),
                //     icon: const Icon(Icons.arrow_drop_down),
                //     iconSize: 24,
                //     isExpanded: true,
                //     dropdownColor: Colors.white,
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //     ),
                //   )),
                // ),
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         alignment: Alignment.centerLeft,
                //         width: 200,
                //         height: 50,
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black54, width: 0.3),
                //           borderRadius:
                //           const BorderRadius.all(Radius.circular(10.0)),
                //         ),
                //         child: Text("$salePrice"),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         alignment: Alignment.centerLeft,
                //         width: 200,
                //         height: 50,
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black54, width: 0.3),
                //           borderRadius:
                //           const BorderRadius.all(Radius.circular(10.0)),
                //         ),
                //         child: Text("$productQuality"),
                //       ),
                //     ),
                //   ],
                // ),
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
                    // Expanded(
                    //   child: TextFormField(
                    //     textAlign: TextAlign.center,
                    //     controller: quantity,
                    //     onChanged: (val) {
                    //       if (val.isNotEmpty) {
                    //         int enteredQuantity = int.tryParse(val) ?? 0;
                    //         if (enteredQuantity > productQuality!) {
                    //           setState(() {
                    //             totalQty = 0;
                    //             errorText =
                    //             'Quality can not be greater than available quanity!';
                    //           });
                    //         } else {
                    //           setState(() {
                    //             totalQty = 0;
                    //             errorText = null;
                    //           });
                    //           changeOrderQty(ChangeOrderProductQtyRequest(
                    //             selectedProductId: product_id,
                    //             selectedProductQuantity:
                    //             productQuality.toString(),
                    //             quantity: val.toString(),
                    //             sale_price: salePrice.toString(),
                    //           ));
                    //         }
                    //       } else {
                    //         setState(() {
                    //           totalQty = 0;
                    //           errorText = null;
                    //           changeOrderQty(ChangeOrderProductQtyRequest(
                    //             selectedProductId: product_id,
                    //             selectedProductQuantity:
                    //             productQuality.toString(),
                    //             quantity: val.toString(),
                    //             sale_price: salePrice.toString(),
                    //           ));
                    //         });
                    //       }
                    //     },
                    //     keyboardType: TextInputType.number,
                    //     validator: validateField,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide:
                    //         const BorderSide(color: Colors.blue, width: 1.0),
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       fillColor: Colors.grey,
                    //       errorText: errorText, // Display the error message
                    //     ),
                    //   ),
                    // ),
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
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     alignment: Alignment.center,
                    //     width: 200,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.black54, width: 0.3),
                    //       borderRadius:
                    //       const BorderRadius.all(Radius.circular(10.0)),
                    //     ),
                    //     child: Text("$totalQty"),
                    //   ),
                    // ),
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile(
                //         title: const Text('Cash'),
                //         activeColor: Colors.pink,
                //         value: "cod",
                //         dense: true,
                //         groupValue: payment,
                //         onChanged: (value) {
                //           setState(() {
                //             payment = value as String;
                //           });
                //         },
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile(
                //         title: const Text('KPay'),
                //         value: "Kpay",
                //         dense: true,
                //         activeColor: Colors.pink,
                //         groupValue: payment,
                //         onChanged: (value) {
                //           setState(() {
                //             payment = value as String;
                //           });
                //         },
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile(
                //         title: const Text('WavePay'),
                //         value: "wavepay",
                //         dense: true,
                //         activeColor: Colors.pink,
                //         groupValue: payment,
                //         onChanged: (value) {
                //           setState(() {
                //             payment = value as String;
                //           });
                //         },
                //       ),
                //     )
                //   ],
                // ),
                const SizedBox(height: 18),
                // Center(
                //     child: ElevatedButton(
                //         onPressed: () {
                //           if (_formKey.currentState!.validate()) {}
                //           context.read<AddOrderCubit>().addOrder(
                //               AddOrderRequestModel(
                //                   firstname: firstname.text.toString(),
                //                   lastname: lastname.text.toString(),
                //                   email: email.text.toString(),
                //                   mobile: mobile.text.toString(),
                //                   line1: line1.text.toString(),
                //                   line2: line2.text.toString(),
                //                   selectedCountry: select_country.toString(),
                //                   selectedTownship: select_township.toString(),
                //                   selectedCity: select_city.toString(),
                //                   zipcode: zipcode.text.toString(),
                //                   mode: payment.toString(),
                //                   delivery: serviceId.toString(),
                //                   user_sign: '',
                //                   product_id: product_id.toString(),
                //                   price: salePrice.toString(),
                //                   quantity: quantity.text.toString(),
                //                   user_id: userId.toString(),
                //                   selectedWard: select_ward.toString(),
                //                   selectedStreet: select_street.toString(),
                //                   block_no: block_no.text.toString(),
                //                   floor: floor.text.toString()));
                //         },
                //         child: const Text('Place Order Now')))
              ],
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
