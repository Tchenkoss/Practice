import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestoreauth = FirebaseFirestore.instance;

// Create a new User in the dataBase
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  }) async {
    String response;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      // SharedPreferences Instance
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      //  Storing email in Shared Preferences
      sharedPreferences.setString('email', email.toString());

      // Store Data into Cloud Firestore
      firestoreauth.collection('users').doc(_auth.currentUser?.uid).set({
        'username': username.toString(),
        'email': email.toString(),
        'phoneNo': phoneNumber.toString(),
      });
      response = 'success';
    } on FirebaseAuthException catch (ex) {
      return response = (ex.message.toString());
    }
    return response;
  }

  // SignIn User Function
  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String response;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      // SharedPreferences Instance
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      //  Storing email in Shared Preferences
      sharedPreferences.setString('email', email.toString());

      response = 'success';
    } on FirebaseAuthException catch (ex) {
      return response = (ex.message.toString());
    }
    return response;
  }

// This function will reset the password by sending an email to the subscriber.
  Future<String> forgotPassword({
    required String email,
  }) async {
    String response;
    try {
      await _auth.sendPasswordResetEmail(
        email: email.toString(),
      );
      response = 'success';
    } on FirebaseAuthException catch (ex) {
      return response = (ex.message.toString());
    }
    return response;
  }

  // Deconnect the user.
  void logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    _auth.signOut();
  }
}
