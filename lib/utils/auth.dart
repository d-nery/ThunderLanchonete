import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<GoogleSignInAccount> getSignedInAccount(
    GoogleSignIn googleSignIn) async {
  GoogleSignInAccount account = googleSignIn.currentUser;

  if (account == null) {
    account = await googleSignIn.signInSilently(suppressErrors: true);
  }

  return account;
}

Future<void> signOutFromGoogle(GoogleSignIn googleSignIn) async {
  await googleSignIn.signOut();
}

Future<FirebaseUser> signIntoFirebase(
    GoogleSignInAccount googleSignInAccount) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

  AuthResult authResult =
      await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  ));

  return authResult.user;
}
