// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/screens/landingScreen.dart';
import 'package:madproject/widgets/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:madproject/modles/users_model.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // SignUp User

  Future<User?> signupUser({
    required UserData user,
    required String password,
  }) async {
    try {
      if (user.email.isNotEmpty ||
          password.isNotEmpty ||
          user.name.isNotEmpty) {
        // register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: user.email,
          password: password,
        );
        // add user to your  firestore database
        await _firestore.collection("userData").doc(cred.user!.uid).set({
          'name': user.name,
          'uid': cred.user!.uid,
          'email': user.email,
          'mobileNo': user.mobileNo,
          'address': user.address,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  // logIn user
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return credential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  // for sighout
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen after signing out
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
        (route) => false, // Clear all routes in the stack
      );
    } catch (e) {
      print("Error signing out: $e");
      // Handle sign-out errors here
    }
  }

  // for logIn with google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        String uid = authResult.user!.uid;

        // Reference to the Firestore collection 'users' using the user's UID
        var userDocRef = _firestore.collection('userData').doc(uid);

        // User data to be stored in Firestore
        Map<String, dynamic> userData = {
          'name': authResult.user!.displayName,
          'email': authResult.user!.email,
          'mobileNo': authResult.user!.phoneNumber,
          'uid': authResult.user!.uid,
        };

        // Set the user data in Firestore
        await userDocRef.set(userData, SetOptions(merge: true));

        return authResult;
      }
    } catch (error) {
      showToast(message: '$error');
    }
    return null;
  }
}
