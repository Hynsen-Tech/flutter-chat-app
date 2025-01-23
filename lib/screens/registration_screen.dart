import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat/design/scale_route_transition.dart';
import 'package:flutter_chat/models/login.dart';
import 'package:flutter_chat/widgets/laoding_widget.dart';
import 'package:flutter_chat/widgets/user_image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _username;
  String? _password;

  File? _selectedPicture;

  void _onSubmitted() async {
    if (_selectedPicture == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.all(20),
          content: Text('An image is needed to create the account.'),
        ),
      );
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Navigator.of(context).push(ScaleRoute(page: LoadingWidget()));
        final Map<String, dynamic> result = await Login()
            .registrationWithEmailAndPassword(
                email: _email!,
                username: _username!,
                password: _password!,
                userImage: _selectedPicture!);
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
          if (result['state'] == true) {
            Navigator.of(context).pop();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
              width: 150,
              child: UserImagePicker(onPickImage: (pickedImage) {
                _selectedPicture = pickedImage;
              }),
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
                          prefixIcon: const Icon(Icons.mail)),
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
                          label: const Text('Username'),
                          prefixIcon: const Icon(Icons.account_circle)),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      onSaved: (value) {
                        _username = value;
                      },
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty && value.trim().length < 20) {
                          return null;
                        } else {
                          return 'The username must have at least 20 characters.';
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
                          _password = value;
                          return null;
                        } else {
                          return 'The password must be at least 6 characters long.';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Confirm Password'),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != null && value == _password) {
                          return null;
                        } else {
                          return 'Check Confirmation Password.';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: _onSubmitted,
                      child: Text('Signup'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('I already have an account.'),
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
