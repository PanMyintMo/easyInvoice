import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/get/SizePart/get_all_size_cubit.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/widget/AllSizePageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/ToastMessage.dart';
import 'SizeAddScreen.dart';

class AllSizesScreen extends StatelessWidget {
  const AllSizesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'All Sizes  Screen',
            style: TextStyle(
                color: AdaptiveTheme.of(context).theme.iconTheme.color,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<GetAllSizeCubit>(
            create: (context) {
              final cubit = GetAllSizeCubit(getIt
                  .call()); // Use getIt<ApiService>() to get the ApiService instance
              cubit.getAllSizes();
              return cubit;
            },
          ),
          BlocProvider<DeleteSizeCubit>(
            create: (context) => DeleteSizeCubit(getIt
                .call()), // Use getIt<ApiService>() to get the ApiService instance
          ),
        ], child: const SizeScreen()));
  }

}
class SizeScreen extends StatefulWidget {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
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
                    builder: (context) => const SizeAddScreen(),
                  ),
                );
                if (result == true) {
                  BlocProvider.of<GetAllSizeCubit>(context).getAllSizes();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add New Size',
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
          BlocBuilder<GetAllSizeCubit, GetAllSizeState>(
            builder: (context, state) {
              if (state is GetAllSizeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetAllSizeSuccess) {
                final sizes = state.getAllSize;

                if (sizes.isEmpty) {
                  return const Center(
                    child: Text("No Size Data found."),
                  );
                }

                return BlocConsumer<DeleteSizeCubit, DeleteSizeState>(
                  builder: (context, deleteState) {
                    bool loading = deleteState is DeleteSizeLoading;

                    return AllSizePageWidget(
                      sizes: state.getAllSize,
                      isLoading: loading,

                    );
                  },
                  listener: (context, deleteState) {
                    if (deleteState is DeleteSizeSuccess) {
                      showToastMessage('Deleted size successful.');
                      BlocProvider.of<GetAllSizeCubit>(context)
                          .getAllSizes();
                    } else if (deleteState is DeleteSizeFail) {
                      showToastMessage(
                          'Failed to delete size: ${deleteState.error}');
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
