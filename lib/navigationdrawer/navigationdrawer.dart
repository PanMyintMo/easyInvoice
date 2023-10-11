import 'package:flutter/material.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/mainScreen.dart';
import 'package:easy_invoice/screen/company_profile.dart';
import 'package:easy_invoice/screen/DeliveryPart/DeliveryManScreen.dart';
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
import 'package:easy_invoice/screen/DeliveryPart/AllDeliveryScreen.dart';
import 'package:easy_invoice/screen/FaultyItemPart/AddRequestFaultyItemScreen.dart';
import 'package:easy_invoice/screen/LocationPart/AllTownshipsScreen.dart';
import 'package:easy_invoice/screen/shopkeeperPart/ShopKeeperAddScreen.dart';

import '../screen/AllProductScreen.dart';
import '../screen/DeliveryPart/RequestDeliveryCompanyScreen.dart';
import '../screen/OrderPart/AddOrderScreen.dart';
import '../screen/OrderPart/OrderByDateScreen.dart';
import '../screen/SizeAddScreen.dart';
import '../screen/UserAddScreen.dart';
import 'menuExpansion.dart';

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
              radius: 40,
              backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
              child: url.isEmpty
                  ? const Icon(Icons.account_circle_rounded, size: 80)
                  : null,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    username ?? '',
                    style:  TextStyle(fontSize: 20, color: Colors.blue[400]),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    email ?? '',
                    style:  TextStyle(fontSize: 14, color: Colors.blue[400]),
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
    var color = Colors.blue[300];

    return TextField(
      style:  TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle:  TextStyle(color: color),
        prefixIcon:  Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color!.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItems() {

    final List<MenuItem> categoryItem = [
      MenuItem(
          text: 'All Category',
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllCategoryDetailPage(),
              ),
            );
          }),
      MenuItem(
          text: 'Add Category',
          onClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> sizeMenu = [
      MenuItem(
          text: 'All Size',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllSizesScreen(),
              ),
            );
          }),
      MenuItem(
          text: 'Add Size',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SizeAddScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> deliveryMenu = [
      MenuItem(
          text: 'View Delivery',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllDeliveryScreen(),
              ),
            );
          }),
      MenuItem(
          text: 'Add Delivery',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RequestDeliveryCompanyScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> userMenuItems = [
      MenuItem(
          text: 'All User',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllUserRoleScreen(),
              ),
            );
          }),
      MenuItem(
          text: 'Add User',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserAddScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> productMenu = [
      MenuItem(
          text: 'All Product',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllProductScreen(),
              ),
            );
          }),
      MenuItem(
          text: 'Add Product',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddProductScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> order = [
      MenuItem(
          text: 'All Order',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FetchOrderByDateScreen(),
              ),
            );
          }),
      MenuItem(
          text: 'Add Order',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddOrderScreen(),
              ),
            );
          })
    ];
    final List<MenuItem> locationMenuItems = [
      MenuItem(
          text: 'View Country',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Country(),
              ),
            );
          }),
      MenuItem(
          text: 'View Cities',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Cities(),
              ),
            );
          }),
      MenuItem(
          text: 'View Townships',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Townships(),
              ),
            );
          }),
      MenuItem(
          text: 'View Wards',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Wards(),
              ),
            );
          }),
      MenuItem(
          text: 'View Streets',
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StreetScreen(),
              ),
            );
          }),
    ];

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
            icon: Icons.delivery_dining,
            items: deliveryMenu, ),
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
              icon: Icons.account_circle_rounded,
              items: categoryItem,

          ),
        const SizedBox(height: 16),
        if (utype == 'ADM')
          buildMenuExpansion(
              text: 'Size',
              icon: Icons.format_size,
              items: sizeMenu, ),
        const SizedBox(height: 16),
        buildMenuExpansion(
            text: 'Products',
            icon: Icons.account_circle_rounded,
            items: productMenu, ),
        const SizedBox(height: 16),
        buildMenuExpansion(
            text: 'User Role',
            icon: Icons.account_circle_rounded,
            items: userMenuItems,),
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
          text: 'Order Part',
          icon: Icons.percent_rounded,
          items: order,
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
          buildMenuExpansion(
            text: 'Location',
            icon: Icons.location_pin,
            items: locationMenuItems,
          )
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
}
