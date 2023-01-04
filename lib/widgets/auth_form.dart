import 'package:flutter/material.dart';


class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this.isLoading);

  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext ctx) submitfn;
  bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _username = '';
  var _password = '';

  void _submit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState!.save();
      widget.submitfn(
        _email.trim(),
        _username.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'please enter atleast 4 characters';
                        }
                        return null;
                      }),
                      decoration: InputDecoration(
                        labelText: 'UserName',
                      ),
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 charachters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: ((newValue) {
                      _password = newValue!;
                    }),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Login' : 'signUp'),
                    ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'already have an account',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
