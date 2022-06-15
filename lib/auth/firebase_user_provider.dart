import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RegistrouwuFirebaseUser {
  RegistrouwuFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

RegistrouwuFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RegistrouwuFirebaseUser> registrouwuFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<RegistrouwuFirebaseUser>(
        (user) => currentUser = RegistrouwuFirebaseUser(user));
