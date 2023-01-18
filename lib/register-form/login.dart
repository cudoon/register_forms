

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenges2022/register-form/register.dart';
import 'package:google_fonts/google_fonts.dart';


import '../main.dart';
import 'consts.dart';
import 'globals.dart';
// import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    await Firebase.initializeApp();

    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim())
            .then((value) =>
            // Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp() )));
         Navigator.canPop(context) ? Navigator.pop(context) : null);
      } catch (error) {
        _globalMethods.authErrorHandle(error.message, context);
        print('error occured ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              child: Divider(
                thickness: 0.5,
              ),
              height: 320,
            ),
            Padding(
                child: Text('USER  LOGIN',
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w400
                    )
                ),
                padding: EdgeInsets.only(top: 10)),

            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            //filled: true,
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email Address',
                            fillColor: Theme.of(context).cardColor),
                        onSaved: (value) {
                          _emailAddress = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        key: ValueKey('Password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Please enter a valid Password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            // filled: true,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: 'your Password',
                            fillColor: Theme.of(context).cardColor),
                        onSaved: (value) {
                          _password = value;
                        },
                        obscureText: _obscureText,
                        onEditingComplete: _submitForm,
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 2, horizontal: 20),
                    //     child: TextButton(
                    //         onPressed: () {
                    //          // Navigator.pushNamed(context, ForgetPassword.routeName);
                    //         },
                    //         child: Text(
                    //           'Forget password?',
                    //           style: TextStyle(
                    //               color: Colors.blue.shade900,
                    //               decoration: TextDecoration.underline),
                    //         )),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color:
                                        ColorsConsts.backgroundColor),
                                  ),
                                )),
                            onPressed: _submitForm,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.person,
                                  size: 18,
                                )
                              ],
                            )),
                        SizedBox(width: 20),
                        Container(

                            child: GestureDetector(
                                child: Text('SIGN-UP HERE', style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 22
                              ),),
                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen())),
                            )
                        )

                      ],

                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
