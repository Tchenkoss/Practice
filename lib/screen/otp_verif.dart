import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powereact/components/elevatedwidget.dart';
import 'package:powereact/screen/homescreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:powereact/screen/registerpage.dart';
import '../utils/utils.dart';

class OtpVerification extends StatefulWidget {
  final String phoneNo;
  late String verId;
  late String dialCode;
  OtpVerification(
      {super.key,
      required this.phoneNo,
      required this.verId,
      required this.dialCode});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String otpPin = '';
  bool isLoading = false;

  Future<void> verifyOTP() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: widget.verId,
          smsCode: otpPin,
        ),
      )
          .whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
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
                  'The code has been sent to ${widget.phoneNo}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Enter the code to continue !',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                PinCodeTextField(
                    controller: otpController,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      setState(() {
                        otpPin = value;
                      });
                    }),
                const SizedBox(height: 15),
                ElevatedButtonWidget(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Verify OTP',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                  buttonPressed: () {
                    if (otpPin.length >= 6) {
                      verifyOTP();
                    } else {
                      Utils.toastMessage('Incorrect OTP');
                    }
                  },
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Message not received ?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      verifyOTP();
                      Utils.toastMessage(
                          'OTP code has been resent to ${widget.phoneNo}');
                    },
                    child: Text('Resend',
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
