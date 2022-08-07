import 'package:fire_authentication/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../services/auth.dart';

enum FormStatus { signIn, signUp, passwordReset }

class SignWithEmail extends StatefulWidget {
  const SignWithEmail({Key? key}) : super(key: key);

  @override
  State<SignWithEmail> createState() => _SignWithEmailState();
}

class _SignWithEmailState extends State<SignWithEmail> {
  FormStatus _formStaus = FormStatus.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _formStaus == FormStatus.signIn
              ? buildEMailSignIn()
              : _formStaus == FormStatus.passwordReset
                  ? buildPasswordReset()
                  : buildSignUpWitEmail()),
    );
  }

  SingleChildScrollView buildEMailSignIn() {
    final _signInFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(
              'assets/images/uskudar-university-logo.png',
            ),
            backgroundColor: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _signInFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In with Student E-Mail',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ksecondColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'Please enter a valid e-mail';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'test@st.uskudar.edu.tr',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password cannot be least than 8 character';
                      }
                    },
                    controller: _passwordController,
                    obscureText:
                        true, //You can hide your password with this property
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      hintText: 'test123',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_signInFormKey.currentState!.validate()) {
                          final user =
                              await Provider.of<Auth>(context, listen: false)
                                  .signInUserWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                          if (user?.emailVerified == false) {
                            await _verifyAlert(
                                DialogType.WARNING,
                                Colors.amber,
                                'Please Verify',
                                'We have sent a link to your email. You can sign in after clicking this link and verifying');
                            await Provider.of<Auth>(context, listen: false)
                                .signOut();
                          }
                        }
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        await _verifyAlert(DialogType.ERROR, Colors.red,
                            'Something Went Wrong', '${e.message}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kmainButonColor,
                    ),
                    child: Text(
                      'Sign In',
                      style: kbutonTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _formStaus = FormStatus.signUp;
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      "Don't you have an account?",
                      style: TextStyle(
                        color: ksecondColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _formStaus = FormStatus.passwordReset;
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      "Do you forget your password?",
                      style: TextStyle(
                        color: ksecondColor,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildSignUpWitEmail() {
    final _signUpFormKey = GlobalKey<FormState>();
    TextEditingController _signEmailController = TextEditingController();
    TextEditingController _signPasswordController = TextEditingController();
    TextEditingController _signConfirmController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(
              'assets/images/uskudar-university-logo.png',
            ),
            backgroundColor: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up with Student E-Mail',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ksecondColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'Please enter a valid e-mail';
                      } else {
                        return null;
                      }
                    },
                    controller: _signEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Write your student email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password cannot be least than 8 character';
                      } else {
                        return null;
                      }
                    },
                    controller: _signPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != _signPasswordController.text) {
                        return 'Password does not match';
                      } else {
                        return null;
                      }
                    },
                    controller: _signConfirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_signUpFormKey.currentState!.validate()) {
                          final user =
                              await Provider.of<Auth>(context, listen: false)
                                  .createUserWithEmailAndPassword(
                                      _signEmailController.text,
                                      _signPasswordController.text);
                          if (user != null && !user.emailVerified) {
                            await user.sendEmailVerification();
                          }
                          await _verifyAlert(
                              DialogType.INFO,
                              Colors.blue,
                              'Please Verify',
                              'We have sent a link to your email. You can sign in after clicking this link and verifying');
                          await Provider.of<Auth>(context, listen: false)
                              .signOut();
                          setState(() {
                            _formStaus = FormStatus.signIn;
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        await _verifyAlert(DialogType.ERROR, Colors.red,
                            'Something Went Wrong', '${e.message}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kmainButonColor,
                    ),
                    child: Text(
                      'Sign Up',
                      style: kbutonTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _formStaus = FormStatus.signIn;
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      "Do you already have an account?",
                      style: TextStyle(
                        color: ksecondColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildPasswordReset() {
    final _passwordResetFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(
              'assets/images/uskudar-university-logo.png',
            ),
            backgroundColor: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _passwordResetFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Password Reset',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ksecondColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'Please enter a valid e-mail';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'test@st.uskudar.edu.tr',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_passwordResetFormKey.currentState!.validate()) {
                          await Provider.of<Auth>(context, listen: false)
                              .sendPasswordResetEmail(_emailController.text);
                          await _verifyAlert(
                              DialogType.INFO,
                              Colors.blue,
                              'Reset Password',
                              'We have sent a link to your email. You can reset your password after clicking this link');
                          Navigator.pop(context);
                        }
                      } on FirebaseAuthException catch (e) {
                        await _verifyAlert(DialogType.ERROR, Colors.red,
                            'Something Went Wrong', '${e.message}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kmainButonColor,
                    ),
                    child: Text(
                      'Send',
                      style: kbutonTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _formStaus = FormStatus.signIn;
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      "Do you remember your password?",
                      style: TextStyle(
                        color: ksecondColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _verifyAlert(DialogType dialogType, Color buttonColor,
      String title, String desc) async {
    return await AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnCancelColor: buttonColor,
      btnCancelOnPress: () {},
    ).show();
  }
}
