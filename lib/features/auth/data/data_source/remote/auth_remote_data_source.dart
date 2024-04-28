import 'dart:async';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel?> get currentUser;
  Future<bool?> get isLogin;
  Future<bool> signOut();
  Future<bool> signInWithGoogle();
  Future<bool> signInwithFacebook();
  Future<String?> singInWithPhone(String phone);
  Future<void> createUser(UserModel userModel);
  Future<bool> isUserExists(String id);
  UserModel getUserModel(User user, AuthOption authOption);
  Future<bool> updateCurrentUser(UserEntity userEntity);
  Future<void> verifyOTP(String verificationId, String userOtp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  AuthRemoteDataSourceImpl({required this.auth, required this.firestore});
  // User? user;
  @override
  Future<bool> signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      return true;
    } catch (e) {
      print("Error here: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<bool> isUserExists(String id) async {
    final reasult = await firestore
        .collection('users')
        .where('userID', isEqualTo: id)
        .get();
    return reasult.docs.isNotEmpty;
  }

  @override
  // TODO: implement user
  Stream<UserModel?> get currentUser async* {
    try {
      final user = auth.currentUser;
      final snapshot = firestore.collection('users').doc(user!.uid).snapshots();
      StreamController<UserModel?> streamController =
          StreamController<UserModel?>();
      StreamSubscription streamSubscription = snapshot.listen((event) {
        if (event.exists && event.data() != null) {
          final userData = event.data();
          UserModel userModel = UserModel.fromJson(userData!);
          streamController.sink.add(userModel);
        }
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("Error here: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
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
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user;
        user = userCredential.user;
        if (user != null) {
          if (!await isUserExists(user!.uid)) {
            UserModel userModel = getUserModel(user!, AuthOption.Google);
            await createUser(userModel);
          }
          return true;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        return false;
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        return false;
      }
      return false;
    } catch (e) {
      // handle the error here
      print("Error here: ${e.toString()}");
      throw Exception(e.toString());
      //return false;
    }
  }

  @override
  Future<bool> signInwithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await auth.signInWithCredential(facebookAuthCredential);
      User? user;
      user = userCredential.user;
      if (user != null) {
        if (!await isUserExists(user.uid)) {
          UserModel userModel = getUserModel(user, AuthOption.Facebook);
          await createUser(userModel);
        }
        return true;
      }
      return false;
    } catch (e) {
      // handle the error here
      print("Error here: ${e.toString()}");
      throw Exception(e.toString());
      // return false;
    }
  }

  @override
  Future<String?> singInWithPhone(String phone) async {
    try {
      String? verificationID;
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          // Sign the user in (or link) with the auto-generated credential
          final UserCredential userCredential =
              await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          if (error.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            print("Error here: ${error.toString()}");
            throw Exception(error.toString());
          } else {
            print("Error here: ${error.toString()}");
            throw Exception(error.toString());
          }
        },
        codeSent: (verificationId, forceResendingToken) async {
          // Update the UI - wait for the user to enter the SMS code
          verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('code Auto Retrieval Timeout');
        },
      );
      //     .then((value) {

      // });
      await Future.delayed(const Duration(seconds: 20));
      return verificationID;
    } catch (e) {
      print("Error here: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createUser(UserModel userModel) async {
    try {
      final userCollectionRef = await firestore
          .collection("users")
          .doc(userModel.userID)
          .set(userModel.toJson());
    } catch (e) {
      print("Error: $e");
      throw Exception(e.toString());
    }
  }

  @override
  UserModel getUserModel(User user, AuthOption authOption) {
    final UserModel userModel = UserModel(
        userID: user.uid,
        userName: user.displayName,
        phoneNumber: user.phoneNumber,
        photo: user.photoURL,
        email: user.email,
        authOption: authOption);
    return userModel;
  }

  @override
  Future<bool> updateCurrentUser(UserEntity userEntity) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  // TODO: implement uid
  Future<bool?> get isLogin async => auth.currentUser != null ? true : false;

  @override
  Future<void> verifyOTP(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
    } catch (e) {
      print("Error: $e");
      throw Exception(e.toString());
    }
  }
}
