import 'package:firebase_auth/firebase_auth.dart';

class StateModel {
  bool isLoading;
  FirebaseUser user;
  int tb;

  StateModel({
    this.isLoading = false,
    this.user,
  });
}
