import 'package:flutter/material.dart';

import 'package:mebook/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSigningIn = true;
  bool _hasChanged = false;

  @override
  Widget build(BuildContext context) {
    if (!_hasChanged)
      _isSigningIn = ModalRoute.of(context).settings.arguments as bool;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (!_hasChanged) _hasChanged = true;
                      _isSigningIn = !_isSigningIn;
                    });
                  },
                  child: Text(_isSigningIn ? 'Register' : 'Access'),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isSigningIn ? 'Sign In' : 'Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      _isSigningIn ? 'Welcome back!' : 'Welcome, friend!',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, -5), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                top: 50,
                bottom: 50,
                left: 25,
                right: 25,
              ),
              child: AuthForm(_isSigningIn),
            ),
          ],
        ),
      ),
    );
  }
}