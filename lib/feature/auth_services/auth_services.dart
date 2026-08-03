import 'package:firebase_auth/firebase_auth.dart';

class Services {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty) {
      throw 'Please enter your name';
    }

    if (email.trim().isEmpty && password.trim().isEmpty) {
      throw 'Please enter your email and password';
    }

    if (email.trim().isEmpty) {
      throw 'Please enter your email';
    }

    if (password.trim().isEmpty) {
      throw 'Please enter your password';
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Please enter a valid email.';

        case 'email-already-in-use':
          throw 'This email is already registered.';

        case 'weak-password':
          throw 'Password must be at least 6 character long.';

        case 'operation-not-allowed':
          throw 'Email/Password authentication is disabled.';

        case 'network-request-failed':
          throw 'Please check your internet connection.';

        case 'too-many-requests':
          throw 'Too many requests. Please try again later.';

        case 'internal-error':
          throw 'An internal error occured.';

        case 'invalid-credential':
          throw 'Invalid credential provided.';

        default:
          throw e.message ?? 'Something went wrong.';
      }
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    if (email.trim().isEmpty && password.trim().isEmpty) {
      throw 'Please enter your email and password.';
    }

    if (email.trim().isEmpty) {
      throw 'Please enter your email.';
    }

    if (password.trim().isEmpty) {
      throw 'Please enter your password.';
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Please enter a valid email address.';

        case 'user-not-found':
          throw 'No account found with this email.';

        case 'wrong-password':
          throw 'Wrong Password.';

        case 'invalid-credential':
          throw 'Invalid email and password.';

        case 'user-disabled':
          throw 'This account has been disabled.';

        case 'operation-not-allowed':
          throw 'Email/Password sign in is disabled.';

        case 'network-request-failed':
          throw 'Please check your internet connection.';

        case 'too-many-requests':
          throw 'Too many login attmepts. Please try again later.';

        case 'internal-error':
          throw 'An internal error occured. Please try again.';

        default:
          throw e.message ?? 'Something went wrong';
      }
    }
  }
}
