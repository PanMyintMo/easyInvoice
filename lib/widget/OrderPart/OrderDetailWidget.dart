import 'package:easy_invoice/common/BillingCardView.dart';
import 'package:easy_invoice/common/Card.dart';
import 'package:flutter/material.dart';

import '../../common/ProductCardView.dart';
import '../../data/responsemodel/DeliveryPart/OrderDetailResponse.dart';

class OrderDetailWidget extends StatefulWidget {
  final bool isLoading;
  final OrderDetailResponse orderDetailResponse;

  const OrderDetailWidget(
      {super.key, required this.isLoading, required this.orderDetailResponse});

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const Text("Order Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 16),
          CardView(
              id: widget.orderDetailResponse.data.order_id.toString(),
              str1: widget.orderDetailResponse.data.delivery_company,
              str2: widget.orderDetailResponse.data.status,
              str3: widget.orderDetailResponse.data.product_description),
          const SizedBox(height: 16),
          const Text("Billing Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 16),
          BillingCardView(
              str1: widget.orderDetailResponse.data.lastname,
              str2: widget.orderDetailResponse.data.email,
              str3: widget.orderDetailResponse.data.mobile,
              str4: widget.orderDetailResponse.data.block_no,
              str5: widget.orderDetailResponse.data.city_name,
              str6: widget.orderDetailResponse.data.state_name,
              str7: widget.orderDetailResponse.data.country_name,
              str8: widget.orderDetailResponse.data.zipcode),
          const SizedBox(height: 16),
          const Text("Order Items",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

          ProductCardView(imageUrl: widget.orderDetailResponse.data.product_url, str2: widget.orderDetailResponse.data.name, str3: widget.orderDetailResponse.data.sale_price, str4: widget.orderDetailResponse.data.quantity.toString(),),
        ],
      ),
    );
  }
}
