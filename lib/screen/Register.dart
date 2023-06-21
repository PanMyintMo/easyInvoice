import 'package:easy_invoice/bloc/post/sign_up_cubit.dart';
import 'package:easy_invoice/common/HeaderWidget.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:flutter/material.dart';
import 'package:easy_invoice/dataRequestModel/RegisterRequestModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../common/FormValidator.dart';
import '../common/theme_helper.dart';
import '../network/SharedPreferenceHelper.dart';
import 'mainscreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt.call()),
      child: Scaffold(body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is SignUpLoading) {
            _isLoading = true;
            return RegisterForm(isLoading: _isLoading, message: '');
          } else if (state is SignUpSuccess) {
          //  print("Token key is ${state.registerResponse.token}");
            final token= state.registerResponse.token;
            final email=state.registerResponse.email;
            final name= state.registerResponse.name;

            // Set the token using the SessionManager class
            SessionManager().setAuthToken(token).then((_) {
              // print("My tokne is $token");
              // Token is set successfully, do something if needed
            });
            SessionManager().setUserName(name);
            SessionManager().setEmail(email);
              WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  MainPageScreen(),
                ),
              );
            });
          } else if (state is SignUpFail) {
            return Center(child: Text(state.error));
          }
          return RegisterForm(isLoading: _isLoading, message: '',);
        },
      )),
    );
  }
}

class RegisterForm extends StatefulWidget {

  final bool isLoading; // Add the isLoading property
  final String message;

  const RegisterForm({Key? key, required this.isLoading, required this.message})
      : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var password_confirmation = TextEditingController();
  bool _obscureText = true;
  bool checkboxValue = false;


  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username!';
    }
    return null;
  }

  String? _validatePasswordConfirmation() {
    final String passwordValue = password.text;
    final String confirmPasswordValue = password_confirmation.text;

    if (passwordValue != confirmPasswordValue) {
      return 'Password and confirm password do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
          children: [
          const SizedBox(
          height: 150,
          child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded)),
      Container(
        margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                  children: [
              GestureDetector(
              child: Stack(
              children: [
                  Container(
                  padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border:
                Border.all(width: 5, color: Colors.white),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey.shade300,
                size: 80.0,
              ),
            ),
            Container(
              padding:
              const EdgeInsets.fromLTRB(80, 80, 0, 0),
              child: Icon(
                Icons.add_circle,
                color: Colors.grey.shade700,
                size: 25.0,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Container(
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
        child: TextFormField(
          controller: name,
          decoration: ThemeHelper()
              .textInputDecoration('Name', 'Enter your name'),
          validator: _validateUsername,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
        child: TextFormField(
          controller: email,
          decoration: ThemeHelper().textInputDecoration(
              "E-mail address", "Enter your email"),
          keyboardType: TextInputType.emailAddress,
          validator: FormValidator.validateEmail,
        ),
      ),
      const SizedBox(height: 20.0),
      Container(
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
        child: TextFormField(
          controller: password,
          obscureText: !_obscureText,
          decoration: ThemeHelper().textInputDecoration(
            "Password*",
            "Enter your password",
          ),
          validator: FormValidator.validatePassword,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
        child: TextFormField(
          controller: password_confirmation,
          obscureText: !_obscureText,
          decoration: ThemeHelper().textInputDecoration(
            "Re-enter password",
          ),
          validator: FormValidator.validatePassword,
        ),
      ),
      const SizedBox(height: 15.0),
      FormField<bool>(
        builder: (state) {
          return Column(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: checkboxValue,
                      onChanged: (value) {
                        setState(() {
                          checkboxValue = value!;
                          state.didChange(value);
                        });
                      }),
                  const Text(
                    "I accept all terms and conditions.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:
                      Theme
                          .of(context)
                          .colorScheme
                          .error,
                      fontSize: 12),
                ),
              )
            ],
          );
        },
        validator: (value) {
          if (!checkboxValue) {
            return 'You need to accept terms and conditions';
          } else {
            return null;
          }
        },
      ),
      const SizedBox(height: 25.0),
        FractionallySizedBox(
          widthFactor: 0.6,
          child: Stack(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final String? passwordConfirmationError = _validatePasswordConfirmation();

                      if (passwordConfirmationError != null) {
                        // Password and confirm password do not match
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(passwordConfirmationError)),
                        );
                      }
                      final registerRequestModel = RegisterRequestModel(
                        name: name.text,
                        email: email.text,
                        password: password.text,
                        password_confirmation: password_confirmation.text,
                      );

                      context.read<SignUpCubit>().signUp(registerRequestModel);
                    }
                  },
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      'Register'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.isLoading)
                Positioned.fill(
                  child: Container(

                    child:const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              if (widget.message.isNotEmpty)
                Positioned(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: 18,
                      color: widget.message.startsWith('Success') ? Colors.green : Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),

    const SizedBox(height: 25.0),
    const Text(
    "Or create account using social media",
    style: TextStyle(color: Colors.grey),
    ),
    const SizedBox(height: 25.0),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    GestureDetector(
    child: FaIcon(
    FontAwesomeIcons.googlePlus,
    size: 35,
    color: HexColor("#EC2D2F"),
    ),
    onTap: () {
    setState(() {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return ThemeHelper().alartDialog(
    "Google Plus",
    "You tap on GooglePlus social icon.",
    context);
    },
    );
    });
    },
    ),
    const SizedBox(
    width: 30.0,
    ),
    GestureDetector(
    child: Container(
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    border: Border.all(
    width: 5, color: HexColor("#40ABF0")),
    color: HexColor("#40ABF0"),
    ),
    child: FaIcon(
    FontAwesomeIcons.twitter,
    size: 23,
    color: HexColor("#FFFFFF"),
    ),
    ),
    onTap: () {
    setState(() {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return ThemeHelper().alartDialog(
    "Twitter",
    "You tap on Twitter social icon.",
    context);
    },
    );
    });
    },
    ),
    const SizedBox(
    width: 30.0,
    ),
    GestureDetector(
    child: FaIcon(
    FontAwesomeIcons.facebook,
    size: 35,
    color: HexColor("#3E529C"),
    ),
    onTap: () {
    setState(() {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return ThemeHelper().alartDialog(
    "Facebook",
    "You tap on Facebook social icon.",
    context);
    },
    );
    });
    },
    ),
    ],
    )
    ],
    ))
    ],
    ),
    )
    ],
    ),
    );
  }
}

