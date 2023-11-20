import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/core/interface/ifirebase_service.dart';

class FirebaseService implements IFirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<GoogleSignInAccount?> signOut() {
    return _googleSignIn.signOut();
  }

  @override
  Future<GoogleSignInAccount?> signIn() {
    return _googleSignIn.signIn();
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() {
    return _googleSignIn.signInSilently();
  }

  @override
  Future<UserCredential> signInWithCredential(
    GoogleSignInAccount googleSignInAccount,
  ) async {
    var googleSignInAuthentication = await googleSignInAccount.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  User getCurrentUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    return FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> deleteAccount() {
    return FirebaseAuth.instance.currentUser!.delete();
  }
}
