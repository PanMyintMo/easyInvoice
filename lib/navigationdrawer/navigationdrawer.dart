import 'package:easy_invoice/screen/AllSizesScreen.dart';
import 'package:easy_invoice/screen/AllUserRoleScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/AddDeliveryScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/DeliveryManScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/TestingScreen.dart';
import 'package:easy_invoice/screen/LocationPart/CountryScreen.dart';
import 'package:easy_invoice/screen/OrderPart/AddOrderScreen.dart';
import 'package:easy_invoice/screen/UserAddScreen.dart';
import 'package:easy_invoice/screen/mainscreen.dart';
import 'package:easy_invoice/screen/company_profile.dart';
import 'package:flutter/material.dart';
import '../network/SharedPreferenceHelper.dart';
import '../screen/AddCategoryScreen.dart';
import '../screen/AddProductScreen.dart';
import '../screen/AllCategoryScreen.dart';
import '../screen/AllProductScreen.dart';
import '../screen/DeliveryPart/AllDeliveryScreen.dart';
import '../screen/FaultyItemPart/AddRequestFaultyItemScreen.dart';
import '../screen/LocationPart/AllTownshipsScreen.dart';
import '../screen/LocationPart/CityScreen.dart';
import '../screen/ProductInvoicePart/ProductInvoiceScreen.dart';
import '../screen/SizeAddScreen.dart';
import '../screen/WarehousePart/WareHouseTableScreen.dart';
import '../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  String? utype;
  String? username;
  String? url;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserType(); // Retrieve the user type from shared preferences
  }

  // Retrieve the user type from shared preferences
  Future<void> fetchUserType() async {
    final sessionManager = SessionManager();
    final userType = await sessionManager.fetchUserType();
    var userName = await sessionManager.getUsername();
    var userEmail = await sessionManager.getEmail();
    setState(() {
      username = userName ;
      email= userEmail ;
      utype = userType ??
          ''; // Assign the retrieved user type to the 'utype' variable
    });
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Material(
        color: Colors.white70,
        child: ListView(
          children: <Widget>[
            buildHeader(username: username,email: email,url: url ?? ''),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  if (utype == 'SK' || utype == 'ADM')
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPageScreen()),
                          );
                        },
                        child: const Text(
                          'Dashboard',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  const Divider(color: Colors.black12),
                  const SizedBox(
                    height: 16,
                  ),
                  if (utype == 'ADM')
                    buildMenuItem(
                      text: 'Delivery Man',
                      icon: Icons.delivery_dining,
                      onClicked: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DeliveryManScreen(),
                      )),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildMenuExpansion(
                    text: 'Delivery System',
                    txtOne: 'View Delivery',
                    txtTwo: 'Add Delivery',
                    icon: Icons.format_size,
                    listData: [],
                    onClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WarehouseTableScreen(),
                      ));
                    },
                    onClickedItem: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddDeliveryScreen(),
                      ));
                    },
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(
                    height: 16,
                  ),
                  if (utype == 'SK' || utype == 'ADM')
                    ListTile(
                      leading: const Icon(
                        Icons.shop,
                        color: Colors.black,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShopKeeperScreen()),
                          );
                        },
                        child: const Text(
                          'ShopKeeper',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (utype == 'ADM')
                    buildMenuItem(
                        text: 'FaultyItem',
                        icon: Icons.add_business,
                        onClicked: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddRequestFaultyItem(),
                            ))),
                  const SizedBox(
                    height: 16,
                  ),
                  if (utype == 'ADM')
                    buildMenuItem(
                        text: 'Transactions',
                        icon: Icons.add_business,
                        onClicked: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DeliveryManScreen(),
                            ))),
                  const Divider(color: Colors.black12),
                  const SizedBox(
                    height: 16,
                  ),
                  if (utype == 'ADM')
                    buildMenuExpansion(
                      text: 'Category',
                      icon: Icons.category,
                      onClicked: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()),
                        );
                      },
                      onClickedItem: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AllCategoryDetailPage()),
                        );
                      },
                      listData: [],
                      txtTwo: 'All Category',
                      txtOne: 'Add Category',
                    ),
                  const SizedBox(height: 16),
                  if (utype == 'ADM')
                    buildMenuExpansion(
                        text: 'Size',
                        icon: Icons.format_size,
                        listData: [],
                        onClicked: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AllSizesScreen()));
                        },
                        onClickedItem: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SizeAddScreen()));
                        },
                        txtOne: 'All Size',
                        txtTwo: 'Add Size'),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'Product',
                    txtOne: (utype == 'ADM') ? 'All Product' : 'View products',
                    txtTwo: (utype == 'ADM') ? 'Add Product' : '',
                    icon: Icons.format_size,
                    listData: [],
                    onClickedItem: () {
                      if (utype == 'ADM') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddProductScreen(),
                        ));
                      }
                    },
                    onClicked: () {
                      if (utype == 'SK' || utype == 'ADM') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductScreen(),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'Order',
                    txtOne: (utype == 'ADM') ? 'All Order' : 'View Orders',
                    txtTwo: 'Add Order',
                    icon: Icons.update,
                    listData: [],
                    onClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TestingScreen()));
                    },
                    onClickedItem: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddOrderScreen()));
                    },
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 16),
                  if (utype == 'ADM' || utype == 'SK')
                    buildMenuItem(
                      text: 'Product Invoice',
                      icon: Icons.insert_drive_file_sharp,
                      onClicked: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProductInvoiceScreen(),
                      )),
                    ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Company Profile',
                    icon: Icons.camera_outdoor,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompanyProfile(
                        username: username.toString(),
                        email: email.toString(),
                      ),
                    )),
                  ),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'User',
                    txtOne: 'All User',
                    txtTwo: (utype == 'ADM') ? 'Add User' : "",
                    icon: Icons.supervised_user_circle,
                    listData: [],
                    onClicked: () {
                      if (utype == 'ADM' || utype == 'SK') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AllUserRoleScreen()));
                      }
                    },
                    onClickedItem: () {
                      if (utype == 'ADM') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserAddScreen()));
                      }
                    },
                  ),
                  if (utype == 'SK')
                    ListTile(
                      leading: const Icon(
                        Icons.shop,
                        color: Colors.redAccent,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProductInvoiceScreen()),
                          );
                        },
                        child: const Text(
                          'Product Invoice',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  if (utype == 'SK' || utype == 'ADM')
                    buildMenuExpansionLocation(
                        text: 'Location',
                        icon: Icons.supervised_user_circle,
                        listData: [],
                        viewCountries: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Country()));
                        },
                        viewCities: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Cities()));
                        },
                        viewTownships: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Townships()));
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String url,
    required String? username,
    required String? email,

  }) =>
      InkWell(
        child: Container(
          color: Colors.black12,
          height: 250,
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
             CircleAvatar(
                radius: 30,
                backgroundImage: url.isNotEmpty
                    ? NetworkImage(url)
                    : null, // Set backgroundImage to null when url is empty
                child: url.isEmpty
                    ? const Icon(Icons.account_circle_rounded, size: 60) // Use an Icon as default image
                    : null, // Set child to null when url is not empty
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      username ?? '',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      email ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.black;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget buildMenuExpansion(
      {required String text,
      required String txtOne,
      required String txtTwo,
      required IconData icon,
      required List<Widget> listData,
      required VoidCallback onClicked,
      required VoidCallback onClickedItem}) {
    const color = Colors.black;

    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 32),
          Text(
            text,
            style: const TextStyle(color: color),
          ),
        ],
      ),
      children: [
        ListTile(
          leading: (txtOne.isNotEmpty)
              ? const Icon(Icons.production_quantity_limits)
              : null,
          title: GestureDetector(
            onTap: onClicked,
            child: Text(
              txtOne,
              style: const TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          leading: (txtTwo.isNotEmpty) ? const Icon(Icons.add) : null,
          title: GestureDetector(
            onTap: onClickedItem,
            child: Text(
              txtTwo,
              style: const TextStyle(color: color),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMenuExpansionLocation(
      {required String text,
      required IconData icon,
      required List<Widget> listData,
      required VoidCallback viewCountries,
      required VoidCallback viewCities,
      required VoidCallback viewTownships}) {
    const color = Colors.black;

    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 32),
          Text(
            text,
            style: const TextStyle(color: color),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.add),
            title: GestureDetector(
              onTap: viewCountries,
              child: const Text(
                'View Countries',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.accessibility),
            title: GestureDetector(
              onTap: viewCities,
              child: const Text(
                'View Cities',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.accessibility),
            title: GestureDetector(
              onTap: viewTownships,
              child: const Text(
                'View Townships',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      // case 0:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => PeoplePage(),
      //   ));
      //   break;
      // case 1:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => FavouritesPage(),
      //   ));
      //   break;
    }
  }
}
