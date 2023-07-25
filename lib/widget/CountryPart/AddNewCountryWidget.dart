import 'package:easy_invoice/bloc/post/CountryPart/add_request_country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataRequestModel/CountryPart/AddCountry.dart';

class AddNewCountry extends StatefulWidget {
  final bool isLoading;

  const AddNewCountry({super.key, required this.isLoading});

  @override
  State<AddNewCountry> createState() => _AddNewCountryState();
}

class _AddNewCountryState extends State<AddNewCountry> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var name = TextEditingController();
    return Stack(
      children: [
    Center(
    child: Column(
    children: [
      Form(
      key: formKey,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: name,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Country Name',
              hintText: 'Country Name'),
        ),
      ),
    ),
    TextButton(onPressed: (){
    if (formKey.currentState!.validate()){
    formKey.currentState!.save();
    context.read<AddRequestCountryCubit>().addCountry(AddCountry(name: name.text));
    }
    }, child: const Text('Add New Country'))
    ],
    ),
    ),
    if (widget.isLoading)
    Container(
    color: Colors.black54,
    child: const Center(
    child: CircularProgressIndicator(),
    ),
    ),
    ],
    );
  }
}
