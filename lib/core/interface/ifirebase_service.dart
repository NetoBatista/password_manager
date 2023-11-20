import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IFirebaseService {
  Future<GoogleSignInAccount?> signOut();

  Future<GoogleSignInAccount?> signIn();

  Future<GoogleSignInAccount?> signInSilently();

  Future<void> updatePassword(String newPassword);

  Future<UserCredential> signInWithCredential(
    GoogleSignInAccount googleSignInAccount,
  );

  Future<UserCredential> signInAnonymously();

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  );

  Future<void> sendPasswordResetEmail(String email);

  User getCurrentUser();
}
