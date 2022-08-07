import 'package:fire_authentication/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import './email_sign_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _isLoading = false;
  Future<void> signInAnonFunc() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Auth>(context, listen: false).signInAnonymously();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Auth>(context, listen: false).signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              Provider.of<Auth>(context, listen: false).signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Color(0xFF30d5c8),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: SvgPicture.asset('assets/images/student.svg'),
                ),
                SizedBox(
                  height: 5,
                  width: 5,
                  child: OverflowBox(
                    minWidth: 0.0,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 0.0,
                    maxHeight: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'assets/images/uskudar-university-logo.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                ButtonWidget(
                  onPressed: _isLoading ? () {} : signInAnonFunc,
                  width: 270,
                  buttonText: 'Are you visitor ?',
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  onPressed: _isLoading
                      ? () {}
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignWithEmail()));
                        },
                  width: 270,
                  buttonText: 'Sign with student mail',
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  onPressed: _isLoading ? () {} : signInWithGoogle,
                  width: 270,
                  buttonText: 'Sign with Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
