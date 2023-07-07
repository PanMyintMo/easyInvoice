import 'package:easy_invoice/bloc/delete/delete_product_item_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';
import '../module/module.dart';
import '../widget/AllProductWidget.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllProductCubit>(
          create: (context) {
            final cubit = GetAllProductCubit(getIt.call());
            cubit.getAllProduct(); // Call this method to fetch the initial product list
            return cubit;
          },
        ),
        BlocProvider<DeleteProductItemCubit>(
          create: (context) => DeleteProductItemCubit(getIt.call()),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<GetAllProductCubit, GetAllProductState>(
          listener: (context, state) {
            if (state is GetAllProductFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
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
                return AllProductWidget();
              }
            } else if (state is GetAllProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetAllProductFail) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${state.error}'),
                ),
              );
            } else {
              context.read<GetAllProductCubit>().getAllProduct(); // Fetch the initial product list
              return const Center(
                child: Text(
                  'No more products',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}







