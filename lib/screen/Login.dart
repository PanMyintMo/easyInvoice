import 'package:easy_invoice/bloc/post/sign_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/mainscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../common/HeaderWidget.dart';
import '../common/theme_helper.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            if (state is SignInLoading) {
              _isLoading = true; // Set _isLoading to true when loading
              return LoginInForm(
                isLoading: _isLoading,
                message: '',
              );
            } else if (state is SignInSuccess) {
              final token = state.loginResponse.token;
              print("Login Success Status Code is ${state.loginResponse.status}");
              final name = state.loginResponse.name;
              final email = state.loginResponse.email;

              // Set the token using the SessionManager class
              SessionManager().setAuthToken(token).then((_) {
                // print("My tokne is $token");
                // Token is set successfully, do something if needed
              });
              SessionManager().setUserName(name);
              SessionManager().setEmail(email);
              // Navigate to the user profile page after the current frame is completed
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPageScreen(),
                  ),
                );
              });
            } else if (state is SignInFail) {
              return LoginInForm(isLoading: false, message: state.error);
            }

            _isLoading = false; // Set _isLoading to false when not loading

            return LoginInForm(isLoading: _isLoading, message: '');
          },
        ),
      ),
    );
  }
}

class LoginInForm extends StatefulWidget {
  final bool isLoading; // Add the isLoading property
  final String message;

  const LoginInForm({Key? key, required this.isLoading, required this.message})
      : super(key: key);

  @override
  State<LoginInForm> createState() => _LoginInFormState();
}

class _LoginInFormState extends State<LoginInForm> {
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded)),
          const SizedBox(height: 20),
          const Text(
            'DNI Easy Invoice',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: ThemeHelper().textInputDecoration(
                      'Email',
                      'Enter your email',
                    ),
                    validator: FormValidator.validateEmail,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    iconColor: Colors.redAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: 'Password',
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.blueGrey,
                      ), // Set the focused border color
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        semanticLabel:
                            _obscureText ? 'show password' : 'hide password',
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  validator: FormValidator.validatePassword,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Stack(
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context.read<SignInCubit>().signIn(
                                    LoginRequestModel(
                                      email.text,
                                      password.text,
                                    ),
                                  );
                            }
                          },
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              'Login'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.isLoading)
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      //show success or failure message base on the message
                      if (widget.message.isNotEmpty)
                        Positioned(

                          child: Text(
                            widget.message,
                            style: TextStyle(
                                fontSize: 18,
                                color: widget.message.startsWith('Success')
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 140),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextSpan(
                            text: ' Sign up!',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email!';
    }
    final RegExp emailRegex = RegExp(
      r'^[\w+\-.]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*(\.[a-zA-Z]{2,})$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address!';
    }
    final List<String> parts = value.split('@');
    if (parts.length != 2 || parts[1].isEmpty) {
      return 'Please enter a valid email address!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password!';
    }
    final RegExp passwordRegx = RegExp(
      r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=])(?=.{8,})',
    );

    if (!passwordRegx.hasMatch(value)) {
      return 'Password must contain at one number, special character and text, and have a length of 8 characters!';
    }
    return null;
  }
}
