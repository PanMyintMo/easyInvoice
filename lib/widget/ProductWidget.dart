import 'package:easy_invoice/sizeconfig/appstyle.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Center(child: Text(
          'Product List', style: TextStyle(color: Colors.black),)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        child: ListView(
          children:[ Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 13,),
                        prefixIcon: Icon(Icons.search)
                    ),
                  ),
                  ),
                  Container(
                      height: 49,
                      width: 49,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: Colors.black
                      ),
                      // child: SvgPicture.asset(
                      //   'assets/filter.svg',
                      //   width: 49,
                      //   height: 49,
                      // ),
                  )
                ],
              )
            ],
          ),]
        ),
      ),
 );
  }
}
