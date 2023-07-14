import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/AllSizesScreen.dart';
import 'package:easy_invoice/screen/AllUserRoleScreen.dart';
import 'package:easy_invoice/screen/DeliveryPart/AddDeliveryScreen.dart';
import 'package:easy_invoice/screen/OrderPart/AddOrderScreen.dart';
import 'package:easy_invoice/screen/UserAddScreen.dart';
import 'package:easy_invoice/screen/user_profile.dart';
import 'package:flutter/material.dart';
import '../screen/AddCategoryScreen.dart';
import '../screen/AddProductScreen.dart';
import '../screen/AllCategoryScreen.dart';
import '../screen/AllProductScreen.dart';
import '../screen/ProductInvoicePart/ProductInvoiceScreen.dart';
import '../screen/SizeAddScreen.dart';
import '../screen/shopkeeperPart/ShopKeeperAddScreen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  String utype = '';

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
    late String username;
    late String email;
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Colors.white70,
        child: ListView(
          children: <Widget>[
            FutureBuilder<String?>(
                future: SessionManager().getUsername(),
                builder: (context, snapshot) {
                  username = snapshot.data ?? '';
                  return FutureBuilder(
                      future: SessionManager().getEmail(),
                      builder: (context, snapshot) {
                        email = snapshot.data ?? '';
                        return buildHeader(
                            urlImage: urlImage,
                            username: username,
                            email: email,
                            onClicked: () =>
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserProfile(
                                      username: username,
                                      email: email,
                                    ),
                              )),
                            });
                      });
                }),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  if (utype == 'SK')
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.redAccent,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoryScreen()),
                          );
                        },
                        child: const Text('Dashboard',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
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
                            MaterialPageRoute(builder: (context) => ShopKeeperScreen()),
                          );
                        },
                        child: const Text('ShopKeeper',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  const Divider(color: Colors.black12),
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
                              builder: (context) => const SizeAddScreen()));
                        },
                        onClickedItem: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AllSizesScreen()));
                        },
                        txtOne: 'All Size',
                        txtTwo: 'Add Size'),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'Product',
                    txtOne: (utype == 'ADM') ? 'Add Product' : '',
                    txtTwo: (utype == 'ADM') ? 'All Product' : 'View Products',
                    icon: Icons.format_size,
                    listData: [],
                    onClicked: () {
                      if (utype == 'ADM') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddProductScreen(),
                        ));
                      }
                    },
                    onClickedItem: () {
                      if (utype == 'SK') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductScreen(),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'Order',
                    txtOne: 'Add Order',
                    txtTwo: (utype == 'ADM') ? 'All Order' : 'View Orders',
                    icon: Icons.update,
                    listData: [],
                    onClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddOrderScreen()));
                    },
                    onClickedItem: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductScreen()));
                    },
                  ),
                  const SizedBox(height: 16),

                  if(utype == 'SK')
                  buildMenuExpansion(
                    text: 'Delivery System',
                    txtOne:  'Add Delivery' ,
                    txtTwo: 'View Delivery',
                    icon: Icons.format_size,
                    listData: [],
                    onClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddDeliveryScreen(),
                        ));

                    },
                    onClickedItem: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductScreen(),
                        ));

                    },
                  ),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.person,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(
                                username: username,
                                email: email,
                              ),
                        )),
                  ),
                  const SizedBox(height: 16),
                  buildMenuExpansion(
                    text: 'User',
                    txtOne: (utype == 'ADM') ? 'Add User' : '',
                    txtTwo: 'All User',
                    icon: Icons.supervised_user_circle,
                    listData: [],
                    onClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserAddScreen()));
                    },
                    onClickedItem: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllUserRoleScreen()));
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
                            MaterialPageRoute(builder: (context) => const ProductInvoiceScreen()),
                          );
                        },
                        child: const Text('Product Invoice',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  if (utype == 'SK')
                    buildMenuExpansionLocation(
                        text: 'Location',
                        icon: Icons.supervised_user_circle,
                        listData: [],
                        viewCountries: () {},
                        viewCities: () {},
                        viewTownships: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String username,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          color: Colors.black12,
          height: 250,
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      username,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      email,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.black38),
              )
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

  Widget buildMenuExpansion({required String text,
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
          const SizedBox(width: 16),
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
            leading: (txtOne.isNotEmpty) ? Icon(Icons.add) : null,
            title: GestureDetector(
              onTap: onClicked,
              child: Text(
                txtOne,
                style: const TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: (txtTwo.isNotEmpty) ? Icon(Icons.accessibility) : null,
            title: GestureDetector(
              onTap: onClickedItem,
              child: Text(
                txtTwo,
                style: const TextStyle(color: color),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMenuExpansionLocation({required String text,
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
          const SizedBox(width: 30),
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
