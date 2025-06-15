import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._internal();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "712220180828-tn0ssh6tn4p1kgdmgo5b9cluflqjgr8j.apps.googleusercontent.com");

  factory GoogleSignInService() {
    return _instance;
  }

  GoogleSignInService._internal();

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print(
            "Google Sign-In Success: ${account.displayName}, ${account.email}");
      }
      return account;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    print("Signed out from Google");
  }
}
