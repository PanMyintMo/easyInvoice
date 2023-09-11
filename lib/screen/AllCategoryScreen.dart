import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/get/CategoryPart/get_category_detail_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/ToastMessage.dart';
import '../widget/AllCategoryPageWidget.dart';
import 'AddCategoryScreen.dart';


class AllCategoryDetailPage extends StatelessWidget {
  const AllCategoryDetailPage({Key? key}) : super(key: key);

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
            'All Category  Screen',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<GetCategoryDetailCubit>(
            create: (context) {
              final cubit = GetCategoryDetailCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.getCategoryDetail();
              return cubit;
            },
          ),
          BlocProvider<DeleteCategoryCubit>(
            create: (context) => DeleteCategoryCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const AllCategoryScreen()));
  }
}

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
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
                    builder: (context) => const CategoryScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<GetCategoryDetailCubit>(context).getCategoryDetail();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Category',
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
          BlocBuilder<GetCategoryDetailCubit, GetCategoryDetailState>(
            builder: (context, state) {
              if (state is GetCategoryDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCategoryDetailSuccess) {
                final category = state.getAllCategoryDetail;

                if (category.isEmpty) {
                  return const Center(
                    child: Text("No Category Data found."),
                  );
                }

                return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteCategoryLoading;

                    return AllCategoryPageWidget(
                      categories: state.getAllCategoryDetail,
                      isLoading: loading,

                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteCategorySuccess) {
                      showToastMessage('Deleted category successful.');
                      BlocProvider.of<GetCategoryDetailCubit>(context)
                          .getCategoryDetail();
                    } else if (deleteState is DeleteCategoryFail) {
                      showToastMessage(
                          'Failed to delete category: ${deleteState.error}');
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

