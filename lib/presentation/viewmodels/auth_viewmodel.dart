import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading }

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _error;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get error => _error;
  bool get isLoading => _status == AuthStatus.loading;

  Future<void> bootstrap() async {
    final logged = await _repository.isLoggedIn();
    _user = logged ? _repository.currentUser : null;
    _status =
        logged ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final user = await _repository.signInWithGoogle();
      if (user == null) {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
      _user = user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = _readableError(e);
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  String _readableError(Object e) {
    final msg = e.toString();
    if (msg.contains('canceled') || msg.contains('cancelled')) {
      return 'Sign in cancelled';
    }
    if (msg.contains('network')) return 'Network error, please retry';
    return 'Sign in failed. Please try again.';
  }
}
