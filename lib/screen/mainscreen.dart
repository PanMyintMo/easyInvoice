import 'package:easy_invoice/screen/WarehousePart/WareHouseTableScreen.dart';
import 'package:easy_invoice/screen/shopkeeperPart/ShopKeeperProductTableScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/get/MainPagePart/order_filter_by_date_cubit.dart';
import '../bloc/get/WarehousePart/warehouse_product_list_cubit.dart';
import '../common/ThemeHelperUserClass.dart';
import '../data/responsemodel/MainPagePart/MainPageResponse.dart';
import '../data/responsemodel/WarehousePart/WarehouseResponse.dart';
import '../module/module.dart';
import '../navigationdrawer/navigationdrawer.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';

import 'FaultyItemPart/FaultyItems.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageScreen> {
  String utype = '';
  String dropDownValue = 'All Orders';
  String? username;
  String? url;

  List<String> filterItem = [
    "Daily Orders",
    "Weekly Orders",
    "Monthly Orders",
    "Yearly Orders",
    "lastmonth"
  ];

  @override
  void initState() {
    super.initState();
    fetchUserType(); // Retrieve the user type from shared preferences
  }

  // Retrieve the user type from shared preferences
  Future<void> fetchUserType() async {
    final sessionManager = SessionManager();
    final userName = await sessionManager.getUsername();

    final userType = await sessionManager.fetchUserType();
    setState(() {
      utype = userType ??
          ''; // Assign the retrieved user type to the 'utype' variable
      username = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<WarehouseData> warehouseData = [];
    OrderApiResponse? mainPageResponse;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = OrderFilterByDateCubit(getIt.call());
            cubit.fetchDataForDifferentFilterTypes(dropDownValue);
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = WarehouseProductListCubit(getIt.call());
            cubit.warehouseProductList();
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const NavigationDrawerWidget(),
        appBar: utype == 'ADM' ? _buildAdminAppBar() : _buildDefaultAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<OrderFilterByDateCubit, OrderFilterByDateState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return BlocConsumer<WarehouseProductListCubit,
                            WarehouseProductListState>(
                        listener: (context, state) {},
                        builder: (context, warehouseState) {
                          // Combine state1 and state2 to determine UI
                          if (state is OrderFilterByDateLoading ||
                              state is WarehouseProductListLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is OrderFilterByDateSuccess) {
                            if (dropDownValue == 'All Orders') {
                              mainPageResponse = state.selectedResponse;
                            } else if (dropDownValue == 'Daily Orders') {
                              mainPageResponse = state.selectedResponse;
                            } else if (dropDownValue == 'Weekly Orders') {
                              mainPageResponse = state.selectedResponse;
                            } else if (dropDownValue == 'Monthly Orders') {
                              mainPageResponse = state.selectedResponse;
                            } else if (dropDownValue == 'Yearly Orders') {
                              mainPageResponse = state.selectedResponse;
                            } else if (dropDownValue == 'lastmonth') {
                              mainPageResponse = state.selectedResponse;
                            }
                            if (warehouseState is WarehouseProductListSuccess) {
                              warehouseData = warehouseState.warehouseData;
                            } else if (warehouseState
                                is WarehouseProductListFail) {
                              //  showToastMessage(warehouseState.error);
                            }
                          } else if (state is OrderFilterByDateFail) {
                            // showToastMessage(state.error);
                          }

                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: chooseItemIdForm(
                                              DropdownButton<String>(
                                                value: dropDownValue,
                                                items: [
                                                  const DropdownMenuItem<
                                                      String>(
                                                    value: 'All Orders',
                                                    child: Text('All Orders'),
                                                  ),
                                                  ...filterItem.map((item) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(item),
                                                    );
                                                  }).toList(),
                                                ],
                                                onChanged: (value) {
                                                  if (value == dropDownValue) {
                                                    setState(() {
                                                      dropDownValue = value!;
                                                    });
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Error'),
                                                          content: const Text(
                                                              'You need to choose one.'),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'OK'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    setState(() {
                                                      dropDownValue = value!;
                                                    });
                                                  }
                                                  // Fetch data based on the selected dropdown value
                                                  final cubit = context.read<
                                                      OrderFilterByDateCubit>();
                                                  cubit
                                                      .fetchDataForDifferentFilterTypes(
                                                          dropDownValue);
                                                },
                                                underline: const SizedBox(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 24,
                                                isExpanded: true,
                                                dropdownColor: Colors.white,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 100,
                                  color: Colors.white10,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      if (utype == 'ADM')
                                        _buildCardView(
                                            'assets/revenue.png',
                                            'Total Revenue',
                                            '${mainPageResponse?.totalRevenue.toString() ?? 0}',
                                            '\$',
                                            () {}),
                                      _buildCardView(
                                          'assets/sale.jpg',
                                          'Total Sale',
                                          '${mainPageResponse?.totalSales.toString() ?? 0}',
                                          ' (Sales)',
                                          () {}),
                                      _buildCardView(
                                          'assets/profits.png',
                                          'Total Profit',
                                          '${mainPageResponse?.totalProfit.toString() ?? 0}',
                                          '\$',
                                          () {}),
                                      _buildCardView(
                                          'assets/faulty.png',
                                          'Faulty Item',
                                          '${mainPageResponse?.totalFaultyItem.toString() ?? 0}',
                                          ' (Items)', () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllFaultyItemsScreen()));
                                      }),
                                      _buildCardView(
                                        'assets/warehouse.png',
                                        'Ware House',
                                        '${mainPageResponse?.totalWareHouseQuantity.toString() ?? 0}',
                                        '',
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WarehouseTableScreen()), // Replace WarehousePage() with your actual destination page
                                          );
                                        },
                                      ),
                                      if (utype == 'ADM' || utype == 'SK')
                                        _buildCardView(
                                            'assets/shopkeeper.jpg',
                                            'Shop Keeper',
                                            '${mainPageResponse?.shopKeeper.toString() ?? 0}',
                                            '(Item Left)', () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ShopKeeperProductTableScreen()), // Replace WarehousePage() with your actual destination page
                                          );
                                        }),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text("Warehouse Data",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 16,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.teal),
                                    columnSpacing: 40.0,
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'ID',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Sale Price',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Buying Price',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                    rows: warehouseData.map((warehouseData) {
                                      return DataRow(cells: [
                                        DataCell(
                                            Text(warehouseData.id.toString())),
                                        DataCell(Text(warehouseData.name)),
                                        DataCell(Text(warehouseData.sale_price
                                            .toString())),
                                        DataCell(Text(warehouseData.buying_price
                                            .toString())),
                                        DataCell(Text(
                                            warehouseData.quantity.toString())),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "All Order",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.teal),
                                    columnSpacing: 40.0,
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'ID',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Status',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Email',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                    rows: mainPageResponse?.data?.map((data) {
                                          return DataRow(cells: [
                                            DataCell(
                                                Text(data.order_id.toString())),
                                            DataCell(Text(data.name)),
                                            DataCell(
                                                Text(data.status.toString())),
                                            DataCell(
                                                Text(data.quantity.toString())),
                                            DataCell(
                                                Text(data.email.toString())),
                                          ]);
                                        }).toList() ??
                                        [],
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAdminAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white70,
      iconTheme: const IconThemeData(
        color: Colors.red, // Set the color of the navigation icon to black
      ),
      title: const Text(
        'Dashboard',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Icons.search,
        //     color: Colors.red,
        //     size: 20,
        //   ),
        // ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                username.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),


            // IconButton(
            //   onPressed: () {},
            //   icon: url!.isNotEmpty
            //       ? CircleAvatar(
            //           backgroundImage: NetworkImage(url!),
            //           radius: 20,
            //         )
            //       : const Icon(
            //           Icons.account_circle_rounded,
            //           color: Colors.red,
            //           size: 20,
            //         ),
            // )
          ],
        ),
      ],
    );
  }

  AppBar _buildDefaultAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white70,
      iconTheme: const IconThemeData(
        color: Colors.red, // Set the color of the navigation icon to black
      ),
      title: const Text(
        'Easy Invoice',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }
}

Widget _buildCardView(String image, String cardText, String profileText,
    String sign, VoidCallback onTap) {
  return Container(
    width: 200,
    margin: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap, // Use the provided onTap function here
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: onTap, // Use the same onTap function here
                          child: Text(
                            cardText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: (cardText == "Total Revenue" ||
                                      cardText == "Total Sale" ||
                                      cardText == "Total Profit")
                                  ? TextDecoration
                                      .none // No underline for these titles
                                  : TextDecoration.underline,
                              // Underline style for other titles
                              color: (cardText == "Total Revenue" ||
                                      cardText == "Total Sale" ||
                                      cardText == "Total Profit")
                                  ? Colors.black // Change color as needed
                                  : Colors.blue, // Color for other titles
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              profileText,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(sign,
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage(image),
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
