import 'package:flutter/material.dart';
import 'package:powereact/components/Textfieldwidget.dart';
import 'package:powereact/components/elevatedwidget.dart';
import '../ressources/auth.dart';
import '../utils/utils.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  late bool isLoading = false;

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    String response = await AuthMethods().forgotPassword(
      email: emailController.text.toString(),
    );
    setState(() {
      setState(() {
        isLoading = false;
      });
    });
    if (response == 'success' && mounted) {
      Utils.toastMessage('Reset password link has been sent on your email');
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
        title: Text('Reset Password'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                    controller: emailController,
                    labelText: 'E-mail',
                    hintText: 'Enter your e-mail',
                    iconField: Icons.email,
                    onValidator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your email';
                      }
                    }),
                SizedBox(height: 20),
                ElevatedButtonWidget(
                  buttonPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resetPassword();
                    }
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
