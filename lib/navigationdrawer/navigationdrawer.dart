import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/AllSizesScreen.dart';
import 'package:easy_invoice/screen/AllUserRoleScreen.dart';
import 'package:easy_invoice/screen/UserAddScreen.dart';
import 'package:easy_invoice/screen/user_profile.dart';
import 'package:flutter/material.dart';
import '../screen/AddCategoryScreen.dart';
import '../screen/AddProductScreen.dart';
import '../screen/AllCategoryScreen.dart';
import '../screen/AllProductScreen.dart';
import '../screen/SizeAddScreen.dart';

class NavigationDrawerWidget extends StatelessWidget {

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

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
                  buildMenuItemExpansion(
                    text: 'Category',
                    icon: Icons.category,
                    onAddCategoryClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryScreen()),
                      );
                    },
                    onAllCategoryClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => const AllCategoryDetailPage()),
                      );
                    },
                    listData: [],
                  ),

                  const SizedBox(height: 16),
                  buildMenuItemExpansionSize(
                    text: 'Size',
                    icon: Icons.format_size,
                    listData: [],
                    onAllSizeClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllSizesScreen()));
                    },
                    onAddSizeClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SizeAddScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItemExpansionProduct(
                    text: 'Product',
                    icon: Icons.format_size,
                    listData: [],
                    onAllProductClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllProductScreen()));
                    },
                    onAddProductClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddProductScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Order',
                    icon: Icons.update,
                    onClicked: () =>
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const AllProductScreen())),
                  ),
                  const SizedBox(height: 24),
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
                  buildMenuUserExpansion(
                    text: 'User',
                    icon: Icons.supervised_user_circle,
                    listData: [],
                    onAddUserClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserAddScreen()));
                    },
                    onAllUserClicked: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllUserRoleScreen()
                      ));
                    },
                  ),
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

  Widget buildMenuItemExpansion({
    required String text,
    required IconData icon,
    required List<Widget> listData,
    required VoidCallback onAddCategoryClicked,
    required VoidCallback onAllCategoryClicked
  }) {
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
              onTap: onAddCategoryClicked,
              child: const Text(
                'Add Category',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.category),
            title: GestureDetector(
              onTap: onAllCategoryClicked,
              child: const Text(
                'All Category',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildMenuUserExpansion({
    required String text,
    required IconData icon,
    required List<Widget> listData,
    required VoidCallback onAddUserClicked,
    required VoidCallback onAllUserClicked
  }) {
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
              onTap: onAddUserClicked,
              child: const Text(
                'Add User Role',
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
              onTap: onAllUserClicked,
              child: const Text(
                'All User Role',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget buildMenuItemExpansionSize({
    required String text,
    required IconData icon,
    required List<Widget> listData,
    required VoidCallback onAddSizeClicked,
    required VoidCallback onAllSizeClicked
  }) {
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
              onTap: onAddSizeClicked,
              child: const Text(
                'Add Size',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.format_size_rounded),
            title: GestureDetector(
              onTap: onAllSizeClicked,
              child: const Text(
                'All Size',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),

      ],
    );
  }



  Widget buildMenuItemExpansionProduct({
    required String text,
    required IconData icon,
    required List<Widget> listData,
    required VoidCallback onAddProductClicked,
    required VoidCallback onAllProductClicked
  }) {
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
              onTap: onAddProductClicked,
              child: const Text(
                'Add Product',
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: ListTile(
            leading: const Icon(Icons.format_size_rounded),
            title: GestureDetector(
              onTap: onAllProductClicked,
              child: const Text(
                'All Product',
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
