import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'package:permission_handler/permission_handler.dart';

import './../models/User.dart';

class AuthService {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Shared State for Widgets
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged; // firebase user
  PublishSubject loading = PublishSubject();
  FirebaseUser localUser;

  // constructor
  AuthService() {
//    _auth.onAuthStateChanged.listen((user) {
//      localUser = user;
//    });
    user.listen((user) {
      localUser = user;
    });
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  Future<FirebaseUser> googleSignIn() async {
    // LOADING
    loading.add(true);

    // Auth
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);

    // Update
    updateUserData(authResult.user);

    // DONE
    loading.add(false);
//    print('SIGN IN AS: ' + authResult.user.uid);
    return authResult.user;
  }

  // Does user already exist or not
  Future<User> getUser() async {
    if (localUser.uid != null) {
      DocumentSnapshot user = await _db.collection('users')
          .document(localUser.uid).get();

//      print(user.toString());

      if(user.exists) {
        return User.fromFirestore(user);
//        return User.fromFirestore(user);
      }

    }

    return User.initialData();
  }

  void updateUserData(FirebaseUser user) {
    DocumentReference ref = _db.collection('users').document(user.uid);

    ref.setData({
      'email': user.email,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  void updateLearningData(String learning) {
    DocumentReference ref = _db.collection('users').document(localUser.uid);

    ref.setData({'learning': learning}, merge: true);
  }

  Future<void> signOut() async {
    localUser = null;
    return await _auth.signOut();
  }

  // Check if the user has the required permissions
  Future<bool> hasPermissions() async {
    PermissionStatus microphone = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    PermissionStatus storage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    return !(microphone == PermissionStatus.denied ||
        storage == PermissionStatus.denied);
  }

  // Request the permissions from the users - don't worry if they decline.
  Future<void> requestPermissions() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.microphone, PermissionGroup.storage]);
  }
}

final authService = new AuthService();
