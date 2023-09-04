import 'package:easy_invoice/bloc/delete/FaultyPart/delete_faulty_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/get/FaultyItemPart/fetch_all_faulty_item_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/FaultyItemPart/FaultyItemWidget.dart';

class AllFaultyItemsScreen extends StatefulWidget {
  const AllFaultyItemsScreen({Key? key}) : super(key: key);

  @override
  State<AllFaultyItemsScreen> createState() => _AllFaultyItemsScreenState();
}

class _AllFaultyItemsScreenState extends State<AllFaultyItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchAllFaultyItemCubit>(
          create: (context) {
            final cubit = FetchAllFaultyItemCubit(
              getIt.call(),
            ); // Use getIt<ApiService>() to get the ApiService instance
            cubit.fetchAllFaultyItem();
            return cubit;
          },
        ),
        BlocProvider<DeleteFaultyItemCubit>(
          create: (context) => DeleteFaultyItemCubit(
            getIt.call(),
          ),
        ),
      ],
      child: Scaffold(
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
        body: BlocConsumer<FetchAllFaultyItemCubit, FetchAllFaultyItemState>(
          listener: (context, state) {
            if (state is FetchAllFaultyItemFail) {
              showToastMessage('Error: ${state.error}');
            }
          },
          builder: (context, state) {
            if (state is FetchAllFaultyItemLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchAllFaultyItemSuccess) {
              return BlocConsumer<DeleteFaultyItemCubit,DeleteFaultyItemState>
                (builder: (context,delete){
                return FaultyItemWidget(
                   faultyItems: state
                       .fetchAllFaultyItem, // Use state.faultyItems to pass the data to FaultyItemWidget
                 );
              }
                  , listener: (context,delete){
                if (delete is DeleteFaultyItemLoading) {

                } else if (delete is DeleteFaultyItemSuccess) {
                  showToastMessage(delete.deleteResponse.message);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<FetchAllFaultyItemCubit>().fetchAllFaultyItem();
                  });
                } else if (delete is DeleteFaultyItemFail) {
                  showToastMessage(delete.error);
                }
              });

            } else if (state is FetchAllFaultyItemFail) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox(); // Return an empty SizedBox if none of the states match
          },
        ),
      ),
    );
  }
}
