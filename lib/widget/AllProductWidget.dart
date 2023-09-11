import 'package:flutter/material.dart';
import 'package:easy_invoice/bloc/get/ProductPart/get_all_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/CustomButtom.dart';
import '../screen/ProductDetailScreen.dart';
import '../network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/data/responsemodel/common/ProductListItemResponse.dart';

class AllProductWidget extends StatefulWidget {
  final bool isLoading;
  final List<ProductListItem> products;

  const AllProductWidget({
    Key? key,
    required this.isLoading,
    required this.products,
  }) : super(key: key);

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  String utype = '';


  @override
  void initState() {
    super.initState();
    fetchUserType(); // Retrieve the user type from shared preferences

  }

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

    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = widget.products[index];
        return Card(
          color: Colors.white70,
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(products: product),
                ),
              );
              if (result != null) {
                context.read<GetAllProductCubit>().getAllProduct();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(
                    Icons.production_quantity_limits_outlined,
                    color: Colors.grey.shade300,
                    size: 50.0,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product name: ${product.name}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Category Id: ${product.category_id}'),
                        const SizedBox(height: 10,),
                        Text('Stock: ${product.stockStatus}'),
                        const SizedBox(height: 10,),
                        Text('Product Id: ${product.id}'),

                      ],
                    ),
                  ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Date: ${product.createdAt.substring(0, 10)}'),
                  const SizedBox(height: 16,),
                  Center(
                    child: (utype == 'ADM') ? CustomButton(
                      label: 'View Detail Product',
                      onPressed: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(products: product),
                          ),
                        );
                        if (result != null) {
                          context.read<GetAllProductCubit>().getAllProduct();
                        }
                      },
                    ) : null,
                  ),
                  ]
              )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
