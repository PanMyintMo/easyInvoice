import 'package:flutter/material.dart';

import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';

class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({Key? key}) : super(key: key);

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  bool checkboxValue = false;

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              const Expanded(child: Text('Add Order')),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('All Order'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text('Billing Address'),
          const SizedBox(height: 16.0),
          Row(
            children: [
              buildProductContainerText('First Name'),
              buildProductContainerText('Last Name'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: buildProductContainerForm(
                  'First Name',
                  TextInputType.name,
                  name,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Last Name',
                  TextInputType.name,
                  name,
                  validateProductField,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),
          Row(
            children: [
              buildProductContainerText('Phone Number'),
              buildProductContainerText('Email'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: buildProductContainerForm(
                  'Phone no',
                  TextInputType.phone,
                  phone,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Email',
                  TextInputType.emailAddress,
                  email,
                  validateProductField,
                ),
              ),
            ],
          ), const SizedBox(height: 16.0),
          Row(
            children: [
              buildProductContainerText('Line 1'),
              buildProductContainerText('Line 2'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: buildProductContainerForm(
                  'Line 1',
                  TextInputType.name,
                  name,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Line 2',
                  TextInputType.name,
                  name,
                  validateProductField,
                ),
              ),
            ],
          ),


          const SizedBox(height: 16.0),
          Row(
            children: [
              buildProductContainerText('Country'),
              buildProductContainerText('Postcode / Zip: (Optional)'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: buildProductContainerForm(
                  'Country',
                  TextInputType.text,
                  phone,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Postcode',
                  TextInputType.number,
                  email,
                  validateProductField,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Checkbox(
                value: checkboxValue,
                onChanged: (value) {
                  setState(() {
                    checkboxValue = value!;
                  });
                },
              ),
              const Text(
                'Ship to a different address?',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
