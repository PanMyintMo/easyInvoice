import 'package:flutter/material.dart';

import '../../common/FormValidator.dart';
import '../../common/ThemeHelperUserClass.dart';

class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({Key? key}) : super(key: key);

  @override
  State<AddOrderWidget> createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String? payment; // no radio button will be selected on initial

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
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('All Order'),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Billing Address',
            style: TextStyle(fontSize: 18),
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
              Expanded(
                  child: chooseItemIdForm(DropdownButton(
                items: [],
                onChanged: (value) {
                  setState(() {
                    // size_id.text = value;
                  });
                },
                //  value: size_id.text,
                hint: const Text('Select Company Name'),
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ))),
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
       const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                  child: chooseItemIdForm(DropdownButton(
                items: [],
                onChanged: (value) {
                  setState(() {
                    // size_id.text = value;
                  });
                },
                //  value: size_id.text,
                hint: const Text('Select Product'),
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                isExpanded: true,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ))),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Sale Price',
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
              Expanded(
                child: buildProductContainerForm(
                  'Available Qty',
                  TextInputType.number,
                  email,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Qty',
                  TextInputType.number,
                  email,
                  validateProductField,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductContainerForm(
                  'Total',
                  TextInputType.number,
                  email,
                  validateProductField,
                ),
              ),

            ],
          ),
          const SizedBox(height: 16.0),
          const Expanded(child: Text('Payment Method', style: TextStyle(fontSize: 18))),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                    title: const Text('Cash On Delivery'),
                    value: "Cash On Delivery",
                    groupValue: payment,
                    onChanged: (value) {
                      setState(() {
                        payment = value;
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: const Text('Kpay'),
                    value: "Kpay",
                    groupValue: payment,
                    onChanged: (value) {
                      setState(() {
                        payment = value;
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: const Text('Wave pay'),
                    value: "Wave pay",
                    groupValue: payment,
                    onChanged: (value) {
                      setState(() {
                        payment = value;
                      });
                    }),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Align(alignment: Alignment.bottomRight,
              child: ElevatedButton(onPressed: (){}, child: const Text('Place Order Now')))
        ],
      ),
    );
  }
}
