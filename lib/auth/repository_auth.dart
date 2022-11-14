import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';

//Cuando ocurre un error al registrarse
class SignUpFailure implements Exception {}

//Cuando ocurre un error al iniciar sesión
class LogInWithEmailAndPasswordFailure implements Exception {}

//Cuando ocurre un error al iniciar sesión con Google
class LogInWithGoogleFailure implements Exception {}

//Cuando ocurre un error al cerrar sesión
class LogOutFailure implements Exception {}

class AuthenticationRepository {

  //Instancia de FirebaseAuth
  AuthenticationRepository({firebase_auth.FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();


  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  //Stream que emite el usuario actual
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) => firebaseUser == null ? User.empty : firebaseUser.toUser);
  }

  //Método para obtener el usuario actual
  Future<User> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    return firebaseUser == null ? User.empty : firebaseUser.toUser;
  }

  //Método para registrar un usuario
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (_) {
      throw SignUpFailure();
    }
  }

  //Método para iniciar sesión con email y contraseña
  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (_) {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  //Método para iniciar sesión con Google
  Future logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      final user = User(
        id: googleUser.id, 
        name: googleUser.displayName!, 
        email: googleUser.email, 
        photo: googleUser.photoUrl!
        );
      return user;
    } on Exception catch (_) {
      throw LogInWithGoogleFailure();
    }
  }

  //Método para cerrar sesión
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception catch (_) {
      throw LogOutFailure();
    }
  }
  

}extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName ?? '', email: email ?? '', photo: photoURL ?? '');
  }
}