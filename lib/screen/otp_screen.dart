import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powereact/screen/loginpage.dart';
import 'package:powereact/screen/otp_verif.dart';
import '../components/elevatedwidget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../utils/utils.dart';

class OTP extends StatefulWidget {
  const OTP({
    super.key,
  });

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String initialCountry = '+33';
  bool isLoading = false;
  String verID = ' ';

  Future<void> verifyPhone(String phoneNumber) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils.toastMessage(e.message.toString());
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        Utils.toastMessage('OTP has sent to your phone number');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerification(
              verId: verID,
              dialCode: initialCountry,
              phoneNo: _phoneController.text.toString(),
            ),
          ),
        );
        setState(() {
          verID = verificationId;
          isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (e) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Pwrlogo.png',
                  scale: 3,
                ),
                Text(
                  'Welcome to our app!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'Create an account Today',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                IntlPhoneField(
                  controller: _phoneController,
                  showCountryFlag: true,
                  showDropdownIcon: true,
                  initialValue: initialCountry,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButtonWidget(
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  buttonPressed: () {
                    if (_formkey.currentState!.validate()) {
                      verifyPhone(
                          initialCountry + _phoneController.text.toString());
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerification(
                          phoneNo: _phoneController.text.toString(),
                          dialCode: initialCountry,
                          verId: verID,
                        ),
                      ),
                    );
                  },
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue)),
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
