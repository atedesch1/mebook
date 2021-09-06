import 'package:flutter/material.dart';

import 'package:mebook/widgets/auth_form.dart';
import 'package:mebook/widgets/bottom_card.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSigningIn = true;
  bool _hasChanged = false;
  bool _isLoading = false;

  void _trySubmit() {
    setState(() {
      _isLoading = true;
    });
  }

  void _failedFallback() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasChanged)
      _isSigningIn = ModalRoute.of(context).settings.arguments as bool;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        // TODO: Make Stack work with scroll view
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
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
                BottomCard(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: AuthForm(
                      _isLoading, _isSigningIn, _trySubmit, _failedFallback),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
