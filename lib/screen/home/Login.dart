import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_invoice/bloc/post/Login&Register/sign_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_invoice/module/module.dart';
import 'package:easy_invoice/network/SharedPreferenceHelper.dart';
import 'package:easy_invoice/screen/mainScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_invoice/dataRequestModel/Login&Register/LoginRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../common/FormValidator.dart';
import '../../common/HeaderWidget.dart';
import '../../common/theme_helper.dart';
import '../../data/api/ConnectivityService.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt.call()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            final loading = state is SignInLoading;
            if (state is SignInLoading) {
              return LoginInForm(
                isLoading: loading,
                message: '',
              );
            } else if (state is SignInSuccess) {
              final token = state.loginResponse.token;
              final name = state.loginResponse.name;
              final email = state.loginResponse.email;
              final utype = state.loginResponse.utype;
              final id = state.loginResponse.id;
              // Set the token using the SessionManager class
              SessionManager sessionManager = SessionManager();
              sessionManager.setAuthToken(token);
              sessionManager.setUserName(name);
              sessionManager.setEmail(email);
              sessionManager.setUserType(utype);
              sessionManager.setId(id);

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
              return LoginInForm(
                  isLoading: loading,
                  message: "Password is wrong.Please try again.");
            }

            return LoginInForm(isLoading: loading, message: "");
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

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';




  var email = TextEditingController();
  var password = TextEditingController();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();


    
  }
  
  Future<void> handleGoogleLogin() async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );
    try{
      await _googleSignIn.signIn();

      final currentUser= _googleSignIn.currentUser;

      if(currentUser != null){
        //Successfully signed with google
        final email=currentUser.email;
        final name=currentUser.displayName;
        final id=currentUser.id;

        print("Google email is $email");
        print("Google username is $name");
        print("Google username is $id");

        // Check if this Google ID already exists on your server

       // bool googleIdExists=await checkIfGoogleIdExistsOnServer(id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPageScreen()),
        );
      }
      else{
        // Google sign-in failed
        print("Google sign-in failed");
      }

    }
    catch(e){

    }
  }



/* Future<bool> checkIfGoogleIdExistsOnServer(String googleId) {
   // Make an HTTP request to your backend server to check if the Google ID exists
   final response = await Dio.get('your_backend_endpoint/check_google_id?google_id=$googleId');


   if(response.statusCode== 200){
     return true;
   }
   else{
     return false;
   }
 }*/
  

  Future<void> checkIfLoggedIn() async {
    final facebookAccessToken = await FacebookAuth.instance.accessToken;
    if (facebookAccessToken != null) {
      final userData =
          await FacebookAuth.instance.getUserData(fields: "email,name");
      final email = userData['email'];
      final username = userData['name'];


      if (email != null && username != null) {
        //The user is already logged in with facebook
        setState(() {
          isLoggedIn = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPageScreen()),
        );
      }
    }
  }


  Future<void> handleLogin() async{
    final LoginResult result= await FacebookAuth.instance.login(permissions: ['email']);
    if(result.status == LoginStatus.success){
      final userData=await FacebookAuth.instance.getUserData(fields: "email,name");
   final email=userData['email'];
   final username=userData['name'];
      print("Login email is $email");
      print("Login username is $username");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageScreen()),
      );

    }
    else{
      print(result.status);
      print(result.message);
    }

    setState(() {
      isLoggedIn = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
                child: HeaderWidget(150, false, Icons.account_circle_rounded),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Myanmar Easy Invoice',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 50),
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
                          autofillHints: [AutofillHints.email],
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
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          iconColor: Colors.red,
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
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscureText
                                  ? 'show password'
                                  : 'hide password',
                              color: Colors.blueAccent,
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
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              final connectivityService = ConnectivityService();
                              final connectivityResult =
                                  await connectivityService.checkConnectivity();

                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                //Show snackBar for no internet connection

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'No internet connection.Please try again later.')));
                              } else {
                                context.read<SignInCubit>().signIn(
                                      LoginRequestModel(
                                        email.text,
                                        password.text,
                                      ),
                                    );
                              }
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
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Check your email and password.Please try again.",
                                style: TextStyle(
                                    color: widget.message.startsWith('Success')
                                        ? Colors.green.shade900
                                        : Colors.red),
                              )),
                        ),
                      const SizedBox(height: 14),
                      Center(child: Text("OR")),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: FaIcon(
                              FontAwesomeIcons.facebook,
                              size: 35,
                              color: HexColor("#3E529C"),
                            ),
                            onTap: () {
                              //if user is already login with fb
                              if(isLoggedIn){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageScreen()));
                              }
                              else{
                                handleLogin();
                              }

                            },
                          ),
                          SizedBox(width: 30,),
                          GestureDetector(
                            child: FaIcon(
                              FontAwesomeIcons.googlePlus,
                              size: 35,
                              color: HexColor("#EC2D2F"),
                            ),
                            onTap: () {
                              handleGoogleLogin();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
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
                                          builder: (context) =>
                                              const Register(),
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
                  ))
            ],
          ),
        ),
        if (widget.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
