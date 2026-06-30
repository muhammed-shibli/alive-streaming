import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/firebase_constants.dart';

/// Wraps Firebase Auth + Google Sign-In.
///
/// google_sign_in 7.x requires an explicit `initialize()` call before
/// `authenticate()`. On Android the Web OAuth `serverClientId` MUST be
/// provided so that an `idToken` can be returned (which Firebase needs).
class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  bool _googleInitialized = false;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: FirebaseConstants.googleWebClientId,
    );
    _googleInitialized = true;
  }

  /// Performs the Google Sign-In → Firebase credential exchange.
  /// Returns the signed-in [User] on success, throws on failure.
  Future<User?> signInWithGoogle() async {
    await _ensureGoogleInitialized();

    final GoogleSignInAccount account =
        await GoogleSignIn.instance.authenticate();

    final GoogleSignInAuthentication auth = account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
    );

    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _ensureGoogleInitialized();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {
      // ignore — we still want to sign out of Firebase
    }
    await _firebaseAuth.signOut();
  }
}
