import 'package:flutter/material.dart';
import 'package:easy_invoice/bloc/get/ProductPart/get_all_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../common/CustomButton.dart';
import '../screen/ProductDetailScreen.dart';
import '../network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/data/responseModel/common/ProductListItemResponse.dart';

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
          semanticContainer: true, // Set to true to make it a semantic container
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.symmetric(vertical: 12 , horizontal: 12),
          color: Colors.white,
          elevation: 5,
          child: InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen( product: product,),
                ),
              );
              if (result != null) {
                context.read<GetAllProductCubit>().getAllProduct();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  product.url != null
                      ? Image.network(
                    product.url!,
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.fitHeight,
                  )
                      : Icon(
                    Icons.production_quantity_limits_outlined,
                    color: Colors.grey.shade300,
                    size: 80.0,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Product name: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black, // Color for "Product name: "
                                ),
                              ),
                              TextSpan(
                                text: product.name,
                                style:  TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900, // Color for the dynamic product name
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15,),

                        RichText(text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Category Id: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black, // Color for "Product name: "
                              ),
                            ),
                            TextSpan(
                              text: product.category_id.toString(),
                              style:  TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900, // Color for the dynamic product name
                              ),
                            ),
                          ]
                        )),
                        const SizedBox(height: 10,),
                        RichText(text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Stock: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black, // Color for "Product name: "
                                ),
                              ),
                              TextSpan(
                                text: product.stock_status.toString(),
                                style:  TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900, // Color for the dynamic product name
                                ),
                              ),
                            ]
                        )),
                        const SizedBox(height: 10,),
                        RichText(text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Product Id: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black, // Color for "Product name: "
                                ),
                              ),
                              TextSpan(
                                text: product.id.toString(),
                                style:  TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900, // Color for the dynamic product name
                                ),
                              ),
                            ]
                        )),

                      ],
                    ),
                  ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Date: ${product.created_at.substring(0, 10)}'),
                  const SizedBox(height: 16,),
                  Center(
                    child: (utype == 'ADM') ? CustomButton(
                      label: 'View Detail Product',
                      onPressed: ()  {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product),
                          ),
                        );
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

