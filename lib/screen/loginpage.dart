import 'package:flutter/material.dart';
import 'package:powereact/components/Textfieldwidget.dart';
import 'package:powereact/components/elevatedwidget.dart';
import 'package:powereact/screen/homescreen.dart';
import 'package:powereact/screen/otp_screen.dart';
import 'package:powereact/screen/resetpassword.dart';
import 'package:powereact/utils/utils.dart';
import '../ressources/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late bool isLoading = false;

  void signInUser() async {
    setState(() {
      isLoading = true;
    });
    String response = await AuthMethods().signInUser(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
    );
    setState(() {
      isLoading = false;
    });
    if (response == 'success' && mounted) {
      _emailController.clear();
      _passwordController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Pwrlogo.png',
                  scale: 3,
                ),
                TextFieldWidget(
                    controller: _emailController,
                    labelText: 'E-mail',
                    hintText: 'Enter your e-mail',
                    iconField: Icons.email,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email';
                      }
                    }),
                const SizedBox(
                  height: 20,
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
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(),
                        ),
                      ),
                      child: Text(
                        'Forgot your password ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButtonWidget(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                  buttonPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account ?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTP(),
                            ),
                          );
                        },
                        child: Text('Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
