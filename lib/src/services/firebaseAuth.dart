

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
    Future<String?> getUsernameByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await userCollection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.get('name'); // İlk belgenin 'name' alanını döndür
      } else {
        return null;
      }
    } catch (e) {
      print('Firestore error: $e');
      return null;
    }
  }
  // Firestore'dan kullanıcı adını almak için fonksiyon
 
}


