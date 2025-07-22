import 'package:firebase_auth/firebase_auth.dart';
import 'package:pingpong_sample/constants/shared_key_constants.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferenceService _prefsService;

  AuthService(this._prefsService);

  Future<UserCredential?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveToken();
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveToken();
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveToken() async {
    final user = _auth.currentUser;
    final idToken = await user?.getIdToken();
    if (idToken != null) {
      await _prefsService.set(SharedKeyConstants.firebaseIdToken, idToken);
    }
  }

  String? getToken() {
    return _prefsService.get<String>(SharedKeyConstants.firebaseIdToken);
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    await _auth.signOut();
    await _prefsService.set(SharedKeyConstants.firebaseIdToken, null);
  }
}