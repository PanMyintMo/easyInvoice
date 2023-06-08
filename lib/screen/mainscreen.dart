import 'package:flutter/material.dart';
import 'navigationdrawer.dart';

class MainPageScreen extends StatefulWidget {

   MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend the body behind the app bar
        backgroundColor: Colors.white,
        drawer:  NavigationDrawerWidget(),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(
            color: Colors
                .red, // Set the color of the navigation icon to black
          ),
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 20,
                ))
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: [
          Container(
            height: 100,
            color: Colors.white10,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCardView(
                    'assets/revenue.png', 'Total Revenue', 'second ','\$'),
                _buildCardView(
                    'assets/sale.jpg', 'Total Sale', 'second','\$'),
                _buildCardView(
                    'assets/profits.png', 'Total Profit', 'second','\$'),
                _buildCardView(
                    'assets/faulty.png', ' Faulty Item', 'second','\$'),
                _buildCardView(
                    'assets/warehouse.png', 'Ware House', 'second','\$'),
                _buildCardView(
                    'assets/shopkeeper.jpg', 'Shop Keeper', 'second','\$'),
              ],
            ),
          ),
        ]));
  }
}

_buildCardView(String image, String cardText, String profileText, String sign) {
  return Container(
    width: 200,
    margin: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Expanded(
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
                        Text(
                          cardText,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              profileText,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text('\$', style: TextStyle(color: Colors.red)),
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
