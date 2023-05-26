import 'package:flutter/material.dart';
import 'navigationdrawer.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend the body behind the app bar
        backgroundColor: Colors.white,
        drawer: const NavigationDrawerWidget(),
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
                    'assets/revenue.png', 'Total Revenue', 'second text'),
                _buildCardView(
                    'assets/sale.jpg', 'Total Sale', 'second text'),
                _buildCardView(
                    'assets/profits.png', 'Total Profit', 'second text'),
                _buildCardView(
                    'assets/faulty.png', ' Faulty Item', 'second text'),
                _buildCardView(
                    'assets/warehouse.png', 'Ware House', 'second text'),
                _buildCardView(
                    'assets/shopkeeper.jpg', 'Shop Keeper', 'second text'),
              ],
            ),
          ),
        ]));
  }
}

_buildCardView(String image, String cardText, String profileText) {
  return Container(
    width: 200,
    margin: const EdgeInsets.only(left: 5,top: 5,right: 5,bottom: 0),
    child:  Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14)
      ),
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
                        Text(
                          profileText,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                  ],
                ),
             Image(
                image: AssetImage(
                  image,),
                width: 50,
            ),
          ],
        ),
              ),
      ),
      ],
    ),
  )),);
}
