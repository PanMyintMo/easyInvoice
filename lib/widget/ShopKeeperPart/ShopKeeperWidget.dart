import 'package:flutter/material.dart';

import '../../screen/shopkeeperPart/RequestShopKeeper.dart';


class ShopKeeperWidget extends StatefulWidget {
  const ShopKeeperWidget({super.key});

  @override
  State<ShopKeeperWidget> createState() => _ShopKeeperWidgetState();
}

class _ShopKeeperWidgetState extends State<ShopKeeperWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
       child :   Row(
            children: [
              const Text('ShopKeeper Request Products'),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RequestShopKeeperScreen()),
                    );
                  },
                  child: const Text('Request Products'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Receive Products'),
                ),
              ),
            ],
          ),

        ),

      ],
    );
  }
}
