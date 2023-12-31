import 'package:firebase_auth/firebase_auth.dart';
import 'package:yolo/models/user.dart' as u;
class AuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  u.User? _userFromFirebaseUser(User user){
    return user != null ? u.User(uid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String password) async {

    try{
      UserCredential authResult = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser!);
    }catch(e){
      print(e.toString());
    }
  }
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }
  Future signOut() async{

      try{
        return await _auth.signOut();
      }catch(e){
        print(e.toString());
        return null;
      }
    }


}
