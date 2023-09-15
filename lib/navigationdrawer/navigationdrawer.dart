import 'package:flutter/material.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/mainscreen.dart';
import 'package:easy_invoice/screen/company_profile.dart';
import 'package:easy_invoice/screen/DeliveryPart/DeliveryManScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/AddDeliveryScreen.dart';
import 'package:easy_invoice/screen/LocationPart/CountryScreen.dart';
import 'package:easy_invoice/screen/LocationPart/CityScreen.dart';
import 'package:easy_invoice/screen/LocationPart/Wards.dart';
import 'package:easy_invoice/screen/LocationPart/StreetScreen.dart';
import 'package:easy_invoice/screen/ProductInvoicePart/ProductInvoiceScreen.dart';
import 'package:easy_invoice/screen/AllSizesScreen.dart';
import 'package:easy_invoice/screen/AllUserRoleScreen.dart';
import 'package:easy_invoice/screen/AddCategoryScreen.dart';
import 'package:easy_invoice/screen/AddProductScreen.dart';
import 'package:easy_invoice/screen/AllCategoryScreen.dart';
import 'package:easy_invoice/screen/AllProductScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/AllDeliveryScreen.dart';
import 'package:easy_invoice/screen/FaultyItemPart/AddRequestFaultyItemScreen.dart';
import 'package:easy_invoice/screen/LocationPart/AllTownshipsScreen.dart';
import 'package:easy_invoice/screen/shopkeeperPart/ShopKeeperAddScreen.dart';

import '../screen/OrderPart/AddOrderScreen.dart';
import '../screen/OrderPart/OrderByDateScreen.dart';
import '../screen/SizeAddScreen.dart';
import '../screen/UserAddScreen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20);
  String? utype;
  String? username;
  String? url;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserType();
  }

  Future<void> fetchUserType() async {
    final sessionManager = SessionManager();
    final userType = await sessionManager.fetchUserType();
    final userName = await sessionManager.getUsername();
    final userEmail = await sessionManager.getEmail();
    setState(() {
      username = userName;
      email = userEmail;
      utype = userType ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white70,
        child: ListView(
          children: <Widget>[
            buildHeader(
              username: username,
              email: email,
              url: url ?? '',
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItems(),
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
  }) {
    return InkWell(
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
                  : null,
              child: url.isEmpty
                  ? const Icon(Icons.account_circle_rounded, size: 60)
                  : null,
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
  }

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

  Widget buildMenuItems() {
    return Column(
      children: [
        if (utype == 'SK' || utype == 'ADM')
          buildMenuItem(
            text: 'Dashboard',
            icon: Icons.home,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPageScreen(),
                ),
              );
            },
          ),
        const Divider(color: Colors.black12),
        if (utype == 'ADM')
          buildMenuItem(
            text: 'Delivery Man',
            icon: Icons.delivery_dining,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DeliveryManScreen(),
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        buildMenuExpansion(
          text: 'Delivery System',
          txtOne: 'View Delivery',
          txtTwo: 'Add Delivery',
          icon: Icons.format_size,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllDeliveryScreen(),
              ),
            );
          },
          onClickedItem: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddDeliveryScreen(),
              ),
            );
          },
        ),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'SK' || utype == 'ADM')
          buildMenuItem(
            text: 'ShopKeeper',
            icon: Icons.shop,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopKeeperScreen(),
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          buildMenuItem(
            text: 'FaultyItem',
            icon: Icons.add_business,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddRequestFaultyItem(),
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          buildMenuExpansion(
            text: 'Category',
            icon: Icons.category,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllCategoryDetailPage(),
                ),
              );
            },
            onClickedItem: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
            txtTwo: 'Add Category',
            txtOne: 'All Category',
          ),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          buildMenuExpansion(
            text: 'Size',
            icon: Icons.format_size,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllSizesScreen(),
                ),
              );
            },
            onClickedItem: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SizeAddScreen(),
                ),
              );
            },
            txtOne: 'All Size',
            txtTwo: 'Add Size',
          ),
        const SizedBox(height: 16),
        buildMenuExpansion(
          text: 'Product',
          txtOne: (utype == 'ADM') ? 'All Product' : 'View products',
          txtTwo: (utype == 'ADM') ? 'Add Product' : '',
          icon: Icons.format_size,
          onClickedItem: () {
            if (utype == 'ADM') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              );
            }
          },
          onClicked: () {
            if (utype == 'SK' || utype == 'ADM') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllProductScreen(),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
        buildMenuExpansion(
          text: 'Order',
          txtOne: (utype == 'ADM') ? 'All Order' : 'View Orders',
          txtTwo: 'Add Order',
          icon: Icons.update,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FetchOrderByDateScreen(),
              ),
            );
          },
          onClickedItem: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddOrderScreen(),
              ),
            );
          },
        ),
        const Divider(color: Colors.black12),
        const SizedBox(height: 16),
        if (utype == 'ADM' || utype == 'SK')
          buildMenuItem(
            text: 'Product Invoice',
            icon: Icons.insert_drive_file_sharp,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductInvoiceScreen(),
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Company Profile',
          icon: Icons.camera_outdoor,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CompanyProfile(
                  username: username.toString(),
                  email: email.toString(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        buildMenuExpansion(
          text: 'User',
          txtOne: 'All User',
          txtTwo: (utype == 'ADM') ? 'Add User' : "",
          icon: Icons.supervised_user_circle,
          onClicked: () {
            if (utype == 'ADM' || utype == 'SK') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllUserRoleScreen(),
                ),
              );
            }
          },
          onClickedItem: () {
            if (utype == 'ADM') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserAddScreen(),
                ),
              );
            }
          },
        ),
        if (utype == 'SK')
          buildMenuItem(
            text: 'Product Invoice',
            icon: Icons.shop,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductInvoiceScreen(),
                ),
              );
            },
          ),
        if (utype == 'SK' || utype == 'ADM')
          buildMenuExpansionLocation(
            text: 'Location',
            icon: Icons.supervised_user_circle,
            viewCountries: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Country(),
                ),
              );
            },
            viewCities: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Cities(),
                ),
              );
            },
            viewTownships: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Townships(),
                ),
              );
            },
            viewWards: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Wards(),
                ),
              );
            },
            viewStreets: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StreetScreen(),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.green;
    Color? textColor = color;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: () {
        setState(() {
          textColor = (textColor == color) ? Colors.green : color;
        });
        if (onClicked != null) {
          onClicked();
        }
      },
    );
  }

  Widget buildMenuExpansion({
    required String text,
    required String txtOne,
    required String txtTwo,
    required IconData icon,
    required VoidCallback onClicked,
    required VoidCallback onClickedItem,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.greenAccent;

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
      childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      children: [
        ListTile(
          hoverColor: hoverColor,
          subtitle: GestureDetector(
            onTap: onClicked,
            child: Text(
              txtOne,
              style: const TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          hoverColor: hoverColor,
          subtitle: GestureDetector(
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

  Widget buildMenuExpansionLocation({
    required String text,
    required IconData icon,
    required VoidCallback viewCountries,
    required VoidCallback viewCities,
    required VoidCallback viewTownships,
    required VoidCallback viewWards,
    required VoidCallback viewStreets,
  }) {
    const color = Colors.black;
    const hoverColor = Colors.green;

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
      childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
      children: [
        ListTile(
          hoverColor: Colors.greenAccent,
          subtitle: GestureDetector(
            onTap: viewCountries,
            child: const Text(
              'View Countries',
              style: TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          hoverColor: hoverColor,
          subtitle: GestureDetector(
            onTap: viewCities,
            child: const Text(
              'View Cities',
              style: TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          hoverColor: hoverColor,
          subtitle: GestureDetector(
            onTap: viewTownships,
            child: const Text(
              'View Townships',
              style: TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          hoverColor: Colors.greenAccent,
          subtitle: GestureDetector(
            onTap: viewWards,
            child: const Text(
              'View Wards',
              style: TextStyle(color: color),
            ),
          ),
        ),
        ListTile(
          hoverColor: Colors.greenAccent,
          subtitle: GestureDetector(
            onTap: viewStreets,
            child: const Text(
              'View Street',
              style: TextStyle(color: color),
            ),
          ),
        ),
      ],
    );
  }
}
