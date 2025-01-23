import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:path/path.dart' as p;

final _firebase = FirebaseAuth.instance;

class Login {
  Login._internal();

  static final Login _instance = Login._internal();

  factory Login() => _instance;

  Future<Map<String, dynamic>> registrationWithEmailAndPassword(
      {required String email,
      required String username,
      required String password,
      required File userImage}) async {
    String resultMessage = '';
    bool resultState = false;

    try {
      final UserCredential userCredentials = await _firebase
          .createUserWithEmailAndPassword(email: email, password: password);

      //userCredentials.user is not null because then we should be inside the on catch
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}-${p.basename(userImage.path)}');
      await storageRef.putFile(userImage);
      final String imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'username': username,
        'email': email,
        'user_image_url': imageUrl,
      });

      UserModel().setUser(
          userId: userCredentials.user!.uid,
          email: email,
          username: username,
          userImage: imageUrl);

      resultMessage = 'Welcome $username';
      resultState = true;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          resultMessage =
              'Already exists an account with the given email address.';
          break;
        case 'invalid-email':
          resultMessage = 'Email not valid. Please choose a valid email.';
          break;
        default:
          resultMessage = 'Some error occurred. Please check and try again.';
      }
    } on TimeoutException catch (error) {
      resultMessage = 'Timeout. Please try again.';
    } on Error catch (error) {
      resultMessage = 'Some error occurred. Please check and try again.';
    }

    return {
      'message': resultMessage,
      'state': resultState,
    };
  }

  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    String resultMessage = '';
    bool resultState = false;

    try {
      final UserCredential userCredentials = await _firebase
          .signInWithEmailAndPassword(email: email, password: password);

      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .get();

      UserModel().setUser(
        userId: userCredentials.user!.uid,
        email: email,
        username: userData['username'],
        userImage: userData['user_image_url'],
      );

      resultMessage = 'Welcome ${UserModel().getUsername}';
      resultState = true;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          resultMessage =
              'User not found. Please Check your data and try again.';
          break;
        case 'invalid-email':
          resultMessage =
              'Email or password not valid. Please Check your data and try again.';
          break;
        default:
          resultMessage = 'Some error occurred. Please check and try again.';
      }
    } on TimeoutException catch (error) {
      resultMessage = 'Timeout. Please try again.';
    } on Error catch (error) {
      resultMessage = 'Some error occurred. Please check and try again.';
    }

    return {
      'message': resultMessage,
      'state': resultState,
    };
  }
}
