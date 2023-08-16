import 'package:easy_invoice/screen/WarehousePart/WareHouseTableScreen.dart';
import 'package:easy_invoice/screen/shopkeeperPart/ShopKeeperProductTableScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/get/MainPagePart/order_filter_by_date_cubit.dart';
import '../common/ThemeHelperUserClass.dart';
import '../common/ToastMessage.dart';
import '../data/responsemodel/MainPagePart/MainPageResponse.dart';
import '../module/module.dart';
import '../navigationdrawer/navigationdrawer.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageScreen> {
  String utype = '';
  String dropDownValue = 'All Orders';

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
    final userType = await sessionManager.fetchUserType();
    setState(() {
      utype = userType ??
          ''; // Assign the retrieved user type to the 'utype' variable
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderApiResponse? mainPageResponse;

    return BlocProvider(
      create: (context) {
        final cubit = OrderFilterByDateCubit(getIt
            .call()); // Use getIt<ApiService>() to get the ApiService instance
        cubit.fetchDataForDifferentFilterTypes(dropDownValue); // Pass the selected dropdown value
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const NavigationDrawerWidget(),
        appBar: utype == 'ADM' ? _buildAdminAppBar() : _buildDefaultAppBar(),
        body: BlocConsumer<OrderFilterByDateCubit, OrderFilterByDateState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrderFilterByDateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderFilterByDateSuccess) {
              if(dropDownValue == 'All Orders'){
               mainPageResponse= state.selectedResponse;
              }
              else if(dropDownValue == 'Daily Orders'){
                mainPageResponse= state.selectedResponse;
              }
              else if(dropDownValue == 'Weekly Orders'){
                mainPageResponse= state.selectedResponse;
              }
              else if(dropDownValue == 'Monthly Orders'){
                mainPageResponse= state.selectedResponse;
              }
              else if(dropDownValue == 'Yearly Orders'){
                mainPageResponse= state.selectedResponse;
              }
              else if(dropDownValue == 'lastmonth'){
                mainPageResponse= state.selectedResponse;
              }

            }
            else if(state is OrderFilterByDateFail){
              showToastMessage(state.error);
            }

            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: chooseItemIdForm(
                          DropdownButton<String>(
                            value: dropDownValue,
                            items: [
                              const DropdownMenuItem<String>(
                                value: 'All Orders',
                                child: Text('All Orders'),
                              ),
                              ...filterItem.map((item) {
                                return DropdownMenuItem<String>(
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
                                      title: const Text('Error'),
                                      content:
                                          const Text('You need to choose one.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
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
                              final cubit = context.read<OrderFilterByDateCubit>();
                              cubit.fetchDataForDifferentFilterTypes(dropDownValue);
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
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
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
                          '\$',(){}
                        ),
                      _buildCardView(
                        'assets/sale.jpg',
                        'Total Sale',
                        '${mainPageResponse?.totalSales.toString() ?? 0}',
                        ' (Sales)',(){}
                      ),
                      _buildCardView(
                        'assets/profits.png',
                        'Total Profit',
                        '${mainPageResponse?.totalProfit.toString() ?? 0}',
                        '\$',(){}
                      ),
                      _buildCardView(
                        'assets/faulty.png',
                        'Faulty Item',
                        '${mainPageResponse?.totalFaultyItem.toString() ?? 0}',
                        ' (Items)',(){}
                      ),
                      _buildCardView(
                        'assets/warehouse.png',
                        'Ware House',
                        '${mainPageResponse?.totalWareHouseQuantity.toString() ?? 0}',
                        '',() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WarehouseTableScreen()), // Replace WarehousePage() with your actual destination page
                        );
                      },
                      ),
                      if (utype == 'ADM' || utype == 'SK')
                        _buildCardView(
                          'assets/shopkeeper.jpg',
                          'Shop Keeper',
                          '${mainPageResponse?.shopKeeper.toString() ?? 0}',
                          '(Item Left)',(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ShopKeeperProductTableScreen()), // Replace WarehousePage() with your actual destination page
                          );
                        }
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
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

Widget _buildCardView(String image, String cardText, String profileText, String sign, VoidCallback onTap) {
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
                                  ? TextDecoration.none // No underline for these titles
                                  : TextDecoration.underline, // Underline style for other titles
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
