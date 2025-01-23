import 'package:flutter/material.dart';
import 'package:flutter_chat/design/scale_route_transition.dart';
import 'package:flutter_chat/models/login.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/widgets/laoding_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? _email;
  String? _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 20,
                right: 20,
              ),
              width: 180,
              child: Image.asset('assets/images/chat.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          prefixIcon: const Icon(Icons.account_circle)),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      onSaved: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value != null && value.contains('@')) {
                          return null;
                        } else {
                          return 'Please insert a valid email.';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value != null && value.trim().length >= 6) {
                          return null;
                        } else {
                          return 'The password must be at least 6 characters long.';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.of(context)
                              .push(ScaleRoute(page: LoadingWidget()));
                          final Map<String, dynamic> result = await Login()
                              .loginWithEmailAndPassword(
                                  email: _email!, password: _password!);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.all(20),
                                content: Text(
                                  result['message'],
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => RegistrationScreen()));
                      },
                      child: Text('Create an account'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
