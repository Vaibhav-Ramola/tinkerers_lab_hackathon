import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinkerlab_app/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _confirmPassword = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // color: Colors.amber,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter valid e-mail ID";
                          }
                          return null;
                        },
                        onSaved: (newValue) => email = newValue,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
                          ),
                          border: OutlineInputBorder(),
                          label: Text("e-mail"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password field is empty";
                          }
                          if (value.length < 7) {
                            return "password length should be greated then 7 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) => password = newValue,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("password"),
                        ),
                      ),
                      if (_confirmPassword)
                        const SizedBox(
                          height: 20,
                        ),
                      if (_confirmPassword)
                        TextFormField(
                          controller: _confPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please confirm the password";
                            }
                            if (_passwordController.text !=
                                _confPasswordController.text) {
                              _passwordController.clear();
                              _confPasswordController.clear();
                              return "passwords do not match please re enter";
                            }
                            return null;
                          },
                          onSaved: (newValue) => email = newValue,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Confirm password"),
                          ),
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            if (!_confirmPassword) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                auth.signInWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            }
                          },
                          child: _confirmPassword
                              ? const Text("Sign up")
                              : const Text("Login"),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(),
                          if (!_confirmPassword)
                            const Text("New to the community, "),
                          if (!_confirmPassword)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _confirmPassword = !_confirmPassword;
                                });
                              },
                              child: const Text("Hop in!"),
                            ),
                          if (_confirmPassword)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _confirmPassword = !_confirmPassword;
                                });
                              },
                              child: const Text("Login"),
                            ),
                          const Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
