import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;


Future googleAuth() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential authCredential = GoogleAuthProvider.getCredential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
  );

  final AuthResult authResult = await auth.signInWithCredential(authCredential);
  final FirebaseUser firebaseUser = authResult.user;
  assert(firebaseUser.displayName != null);
  assert(firebaseUser.email != null);

  final FirebaseUser currentUser = await auth.currentUser();
  assert(firebaseUser.uid == currentUser.uid);

}

googleSignOut() async {

  await googleSignIn.signOut();
}