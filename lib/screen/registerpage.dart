import 'package:flutter/material.dart';
import 'package:powereact/components/Textfieldwidget.dart';
import 'package:powereact/components/elevatedwidget.dart';
import 'package:powereact/ressources/auth.dart';
import 'package:powereact/screen/homenavigation.dart';

import '../utils/utils.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formey = GlobalKey();
  final bool _passwordVisible = true;
  late bool isLoading = false;

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String response = await AuthMethods().signUpUser(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
      username: _usernameController.text.toString(),
      phoneNumber: _phoneController.text.toString(),
    );
    setState(() {
      isLoading = false;
    });
    if (response == 'success' && mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomenavScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
    }
    if (response != 'success') {
      Utils.toastMessage(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    iconField: Icons.person,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Username';
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                    controller: _emailController,
                    labelText: 'E-mail',
                    hintText: 'Enter your E-mail',
                    iconField: Icons.email,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email';
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                    obscureText: true,
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    iconField: Icons.lock,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                    controller: _phoneController,
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    iconField: Icons.phone,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your phone number';
                      } else if (value.length < 10) {
                        return 'Phone number must be at least 10 characters';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                ElevatedButtonWidget(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Register'),
                    buttonPressed: () {
                      if (_formey.currentState!.validate()) {
                        signUpUser();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
