import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/collection_constants.dart';
import 'package:onco_connect/common/constants/document_constants.dart';
import 'package:onco_connect/common/exceptions/auth_exceptions.dart';
import 'package:onco_connect/common/services/firebase_services.dart';
import 'package:onco_connect/domain/entities/meta/meta_doc.dart';
import 'package:onco_connect/domain/entities/user_entity.dart';

import '../../common/exceptions/data_exception.dart';

abstract class AuthRepository {
  Future<UserEntity?> fetchUser();
  Future<void> signOut();
  Future<bool> createUser({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
  });
  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<MetaDoc> getMetaData();
  Future<UserMetaDoc> getUserMetaData();
  String? getUserId();
}

class AuthRepositoryImpl extends GetxService implements AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AuthRepositoryImpl({
    required IFirebaseServices firebaseServices,
  })  : _firestore = firebaseServices.firestore,
        _auth = firebaseServices.auth;

  @override
  Future<UserEntity?> fetchUser() async {
    String uid = _auth.currentUser!.uid;
    var dataSnapshot =
        await _firestore.collection(CollectionConstants.user).doc(uid).get();
    if (dataSnapshot.exists) {
      var response = dataSnapshot.data()!;
      return UserEntity.fromJson(response);
    }
    return null;
  }

  @override
  Future<bool> createUser({
    required String email,
    required String password,
    required String phoneNo,
    required String username,
  }) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      if (await _createUser(authResult, username, phoneNo)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw UserAuthException(e.toString());
    }
  }

  Future<bool> _createUser(
    UserCredential userCredential,
    String username,
    String phoneNo,
  ) async {
    User fireBaseUser = userCredential.user!;

    if (userCredential.additionalUserInfo!.isNewUser) {
      UserEntity userEntity = UserEntity(
        uid: fireBaseUser.uid,
        email: fireBaseUser.email,
        username: username,
        phoneNo: phoneNo,
        profilePhoto: fireBaseUser.photoURL.toDefaultProfileUrl,
      );

      await _firestore
          .collection(CollectionConstants.user)
          .doc(fireBaseUser.uid)
          .set(userEntity.toJson(), SetOptions(merge: true));

      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  @override
  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      if (!authResult.additionalUserInfo!.isNewUser) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else if (e.code == 'invalid-credential') {
        throw InvalidCredentialException();
      } else {
        throw UserAuthException(e.code.toString());
      }
    }
  }

  @override
  Future<MetaDoc> getMetaData() async {
    try {
      CollectionReference<MetaDoc> metaRef = _firestore
          .collection(CollectionConstants.metaRef)
          .withConverter<MetaDoc>(
            fromFirestore: (snapshot, _) => MetaDoc.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );
      DocumentSnapshot<MetaDoc> snapshot =
          await metaRef.doc(DocumentConstants.metaDoc).get();
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        throw NoAppMetaDataException();
      }
    } on FirebaseException catch (e) {
      throw DataFetchException(e.message, e.stackTrace);
    }
  }

  @override
  Future<UserMetaDoc> getUserMetaData() async {
    try {
      CollectionReference userRef =
          _firestore.collection(CollectionConstants.user);
      CollectionReference<UserMetaDoc> userMetaRef = userRef
          .doc(_auth.currentUser!.uid)
          .collection(CollectionConstants.userMetaRef)
          .withConverter<UserMetaDoc>(
            fromFirestore: (snapshot, _) =>
                UserMetaDoc.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );
      DocumentSnapshot<UserMetaDoc> snapshot =
          await userMetaRef.doc(DocumentConstants.metaQuestionnaireDoc).get();
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        throw NoUserMetaDataException();
      }
    } on FirebaseException catch (e) {
      throw DataFetchException(e.message, e.stackTrace);
    }
  }
}
