import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mebook/utils/auth_service.dart';
import 'package:mebook/widgets/thirdparty_sign_in.dart';

class AuthForm extends StatefulWidget {
  final bool isSigningIn;
  AuthForm(this.isSigningIn);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void tryGoogleSignIn(ctx) {
    FocusScope.of(context).unfocus();
    context.read<AuthService>().googleSignIn(
          context: ctx,
        );
  }

  void tryEmailSignIn(ctx) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context.read<AuthService>().emailSignIn(
          context: ctx, email: _userEmail, password: _userPassword);
    }
  }

  void tryEmailSignUp(ctx) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      context.read<AuthService>().emailSignUp(
          context: ctx,
          email: _userEmail,
          username: _userName,
          password: _userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: ValueKey('email'),
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email address'),
            onSaved: (value) {
              _userEmail = value;
            },
          ),
          SizedBox(
            height: 14,
          ),
          if (!widget.isSigningIn) ...[
            TextFormField(
              key: ValueKey('username'),
              validator: (value) {
                if (value.isEmpty || value.length < 4) {
                  return 'Please enter at least 4 characters.';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Username'),
              onSaved: (value) {
                _userName = value;
              },
            ),
            SizedBox(
              height: 14,
            ),
          ],
          TextFormField(
            key: ValueKey('password'),
            validator: (value) {
              if (value.isEmpty || value.length < 7) {
                return 'Password must be at least 7 characters long.';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onSaved: (value) {
              _userPassword = value;
            },
          ),
          if (widget.isSigningIn)
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Forgot Password?'),
              ),
            ),
          if (!widget.isSigningIn) SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.isSigningIn
                      ? () {
                          tryEmailSignIn(context);
                        }
                      : () {
                          tryEmailSignUp(context);
                        },
                  child: Text(widget.isSigningIn ? 'Sign In' : 'Sign Up'),
                ),
              )
            ],
          ),
          if (widget.isSigningIn) ...[
            SizedBox(
              height: 48,
              child: Divider(),
            ),
            ThirdPartySignIn(
              logo: AssetImage('assets/google_logo.png'),
              serviceName: 'Google',
              signIn: () {
                tryGoogleSignIn(context);
              },
            ),
          ],
        ],
      ),
    );
  }
}
