import 'package:easy_invoice/bloc/get/get_all_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/CustomButtom.dart';
import '../screen/ProductDetailScreen.dart';

class AllProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProductCubit, GetAllProductState>(
      builder: (context, state) {
        if (state is GetAllProductSuccess) {
          if (state.products.isEmpty) {
            return const Center(
              child: Text(
                'No more products',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {},
                ),
                title: const Text(
                  'All Product',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.red,
                      size: 20,
                    ),
                  )
                ],
              ),
              body: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(products: product),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      height: 150,
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
                                Expanded(
                                  child: Text(
                                    'Product name: ${product.name}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text('Category Id: ${product.categoryId}'),
                                ),
                                Expanded(
                                  child: Text('Stock: ${product.stockStatus}'),
                                ),
                                Expanded(
                                  child: Text('Product Id: ${product.id}'),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Date: ${product.createdAt.substring(0, 10)}'),
                              Expanded(
                                child: Center(
                                  child: CustomButton(
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else if (state is GetAllProductLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is GetAllProductFail) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.error}'),
            ),
          );
        } else {
          return const SizedBox(); // Return an empty widget if none of the states match
        }
      },
    );
  }
}
