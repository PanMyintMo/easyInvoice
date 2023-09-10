import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/ToastMessage.dart';
import 'AddRequestFaultyItemScreen.dart';
import '../../bloc/get/FaultyItemPart/fetch_all_faulty_item_cubit.dart';
import '../../bloc/delete/FaultyPart/delete_faulty_item_cubit.dart';
import '../../module/module.dart';
import '../../widget/FaultyItemPart/FaultyItemWidget.dart';

class AllFaultyItemsScreen extends StatelessWidget {
  const AllFaultyItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(
          color: Colors.red, // Set the color of the navigation icon to black
        ),
        title: const Text(
          'Faulty Items Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchAllFaultyItemCubit>(
            create: (context) => FetchAllFaultyItemCubit(
              getIt.call(),
            )..fetchAllFaultyItem(),
          ),
          BlocProvider<DeleteFaultyItemCubit>(
            create: (context) => DeleteFaultyItemCubit(
              getIt.call(),
            ),
          ),
        ],
        child: const FaultyItemDefault(),
      ),
    );
  }
}

class FaultyItemDefault extends StatelessWidget {
  const FaultyItemDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddRequestFaultyItem(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<FetchAllFaultyItemCubit>(context).fetchAllFaultyItem();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Faulty Item',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<FetchAllFaultyItemCubit, FetchAllFaultyItemState>(
            builder: (context, state) {
              if (state is FetchAllFaultyItemLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllFaultyItemSuccess) {
                final faultyItems = state.fetchAllFaultyItem;

                if (faultyItems!.isEmpty) {
                  return const Center(
                    child: Text("No faulty items found."),
                  );
                }

                return BlocConsumer<DeleteFaultyItemCubit, DeleteFaultyItemState>(
                  builder: (context, state) {
                    final bool loading = state is DeleteFaultyItemLoading;


                    return FaultyItemWidget(
                      faultyItems: faultyItems, isLoading: loading,
                    );
                  },
                  listener: (context, state) {
                    if (state is DeleteFaultyItemLoading) {

                    } else if (state is DeleteFaultyItemSuccess) {
                      showToastMessage('Deleted Faulty Item successful.');
                      context.read<FetchAllFaultyItemCubit>().fetchAllFaultyItem();
                    } else if (state is DeleteFaultyItemFail) {
                      showToastMessage(
                          'Failed to delete faulty item: ${state.error}');
                    }
                  },
                );
              } else {
                return const SizedBox(); // Handle other states if needed
              }
            },
          ),
        ],
      ),
    );
  }
}
