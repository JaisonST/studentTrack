import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:studenttrack/AuthenticationSystem/User.dart';


class AuthServices {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Users _usersFromFirebaseUser(auth.User user) {
    return user != null ? Users(uid: user.uid): null;
  }

  Stream<Users> get user{
    return _auth.authStateChanges().map(_usersFromFirebaseUser);
  }

  Future signIn(String email, String password) async {
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      auth.User user = result.user;

      return _usersFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}