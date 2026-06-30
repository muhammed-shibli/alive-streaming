import 'dart:async';

import '../../core/services/auth_service.dart';
import '../../core/services/storage_service.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class AuthRepository {
  AuthRepository({
    AuthService? authService,
    StorageService? storageService,
    UserRepository? userRepository,
  })  : _authService = authService ?? AuthService(),
        _storageService = storageService ?? StorageService(),
        _userRepository = userRepository ?? UserRepository();

  final AuthService _authService;
  final StorageService _storageService;
  final UserRepository _userRepository;

  Future<bool> isLoggedIn() async {
    final cached = await _storageService.isLoggedIn();
    return cached && _authService.currentUser != null;
  }

  Future<UserModel?> signInWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    if (user == null) return null;
    final model = UserModel(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
    await _storageService.setLoggedIn(true);
    // Fire-and-forget Firestore write — must NOT block the login flow.
    // If Firestore is unreachable or the database isn't created in the
    // Firebase project, the call can hang indefinitely otherwise.
    unawaited(
      _userRepository
          .upsert(model)
          .timeout(const Duration(seconds: 5))
          .catchError((_) {}),
    );
    return model;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    await _storageService.clear();
  }

  UserModel? get currentUser {
    final u = _authService.currentUser;
    if (u == null) return null;
    return UserModel(
      uid: u.uid,
      displayName: u.displayName,
      email: u.email,
      photoUrl: u.photoURL,
    );
  }
}
