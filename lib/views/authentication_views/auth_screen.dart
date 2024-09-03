import 'package:flutter/material.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/constants/components.dart';
import 'package:task_management_app/controllers/authentication_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  bool isSignedUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignedUp ? 'Sign Up' : 'Sign In'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(child: Container()), // Spacer to push content down
                        TextFormField(
                          controller: _emailController,
                          decoration: inputTextField.copyWith(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: primaryColor,
                            ),
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: inputTextField.copyWith(
                            prefixIcon: Icon(
                              Icons.key_rounded,
                              color: primaryColor,
                            ),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 10) {
                              return 'Password must be at least 10 characters long';
                            }
                            return null;
                          },
                        ),
                        if (isSignedUp) const SizedBox(height: 10),
                        if (isSignedUp)
                          TextFormField(
                            controller: _repasswordController,
                            decoration: inputTextField.copyWith(
                              prefixIcon: Icon(
                                Icons.key_rounded,
                                color: primaryColor,
                              ),
                              hintText: 'Confirm Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm a password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },

                          ),
                        if (isSignedUp) const SizedBox(height: 10),
                        if (isSignedUp)
                          TextFormField(
                            controller: _usernameController,
                            decoration: inputTextField.copyWith(
                              prefixIcon: Icon(
                                Icons.abc_rounded,
                                color: primaryColor,
                              ),
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                        if (isSignedUp) const SizedBox(height: 10),
                        if (isSignedUp)
                          TextFormField(
                            controller: _roleController,
                            decoration: inputTextField.copyWith(
                              prefixIcon: Icon(
                                Icons.person_2_rounded,
                                color: primaryColor,
                              ),
                              hintText: 'Role',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your role';
                              }
                              return null;
                            },
                          ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              if (isSignedUp) {
                                await _authenticationController.signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  _usernameController.text,
                                  _roleController.text,
                                );
                              } else {
                                await _authenticationController.signIn(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              }
                            }
                          },
                          style: inputPrimaryButton,
                          child: Text(
                            isSignedUp ? 'Sign Up' : 'Sign In',
                            style: TextStyle(
                                color: whiteTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSignedUp
                                ? 'Already have an account?'
                                : 'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignedUp = !isSignedUp;
                                  });
                                },
                                child: Text(
                                  isSignedUp
                                  ? ' Sign In'
                                  : ' Sign Up',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
