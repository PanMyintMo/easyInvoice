import 'package:easy_invoice/bloc/edit/CityPart/edit_ward_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/edit/CityPart/edit_city_cubit.dart';
import '../../bloc/get/CityPart/fetch_all_ward_cubit.dart';
import '../../common/ToastMessage.dart';
import '../../module/module.dart';
import '../../widget/CityPart/EditWardWidget.dart';

class EditWardScreen extends StatelessWidget {
  final String township_id;
  final String ward_name;


  const EditWardScreen(
      {super.key,
      required this.township_id,
      required this.ward_name,
     });

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
          'Edit Ward Screen',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FetchAllWardCubit>(
            create: (context) => FetchAllWardCubit(
              getIt.call(),
            )..fetchAllWard(),
          ),
          BlocProvider<EditWardCubit>(
            create: (context) => EditWardCubit(
              getIt.call(),
            ),
          ),
        ],
        child: EditWard(ward_name: ward_name, township_id: township_id,

        ),
      ),
    );
  }
}

class EditWard extends StatefulWidget {
  final String township_id;
  final String ward_name;

  const EditWard({super.key, required this.township_id, required this.ward_name});

  @override
  State<EditWard> createState() => _EditWardState();
}

class _EditWardState extends State<EditWard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          BlocBuilder<FetchAllWardCubit, FetchAllWardState>(
            builder: (context, state) {
              if (state is FetchAllWardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllWardSuccess) {
                final wardResponse = state.ward;
                return BlocConsumer<EditWardCubit, EditWardState>(
                  builder: (context, state) {
                    final bool loading = state is EditWardLoading;
                    return EditWardWidget(
                      ward_name:widget.ward_name,
                      isLoading: loading,
                      township_id: widget.township_id, ward: wardResponse,
                     );
                  },
                  listener: (context, state) {
                    if (state is EditWardLoading) {
                    } else if (state is EditWardSuccess) {
                      showToastMessage('Updated successful.');
                      context
                          .read<FetchAllWardCubit>()
                          .fetchAllWard();
                    } else if (state is EditWardFail) {
                      showToastMessage(
                          'Failed to update ward item: ${state.error}');
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
