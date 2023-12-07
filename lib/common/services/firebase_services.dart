import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get_state_manager/get_state_manager.dart';

abstract class IFirebaseServices {
  FirebaseFirestore get firestore;
  FirebaseAuth get auth;
  void printMe();
}

class FirebaseServices extends GetxService implements IFirebaseServices {
  late FirebaseFirestore _firebaseFireStore;
  late FirebaseAuth _firebaseAuth;

  @override
  onInit() {
    _firebaseFireStore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    super.onInit();
  }

  @override
  FirebaseFirestore get firestore => _firebaseFireStore;

  @override
  FirebaseAuth get auth => _firebaseAuth;

  @override
  void printMe() {
    debugPrint("✨✨Print Me :)");
  }
}
