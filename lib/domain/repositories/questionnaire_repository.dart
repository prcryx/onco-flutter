import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onco_connect/common/constants/collection_constants.dart';
import 'package:onco_connect/common/constants/document_constants.dart';
import 'package:onco_connect/common/exceptions/data_exception.dart';
import 'package:onco_connect/common/services/firebase_services.dart';
import 'package:onco_connect/domain/entities/meta/meta_doc.dart';
import 'package:onco_connect/domain/entities/questionnaire_entity.dart';
import 'package:onco_connect/domain/entities/user_questionnaire_response.dart';

abstract class QuestionnaireRepository {
  Future<QuestionnaireEntity> fetchFirstQuestion();
  Future<List<QuestionnaireEntity?>> fetchQuestionnaire();
  Future<bool> createNewAssessment({
    required String photoUrl,
    required String question,
    required List<String> options,
  });
  Future<List<UserQuestionnaireResponse>?> fetchUserResponse();
  Future<bool> submitUserResponse(UserQuestionnaireResponse res);

  String getUserId();
}

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  QuestionnaireRepositoryImpl({
    required IFirebaseServices firebaseServices,
  })  : _auth = firebaseServices.auth,
        _firestore = firebaseServices.firestore;

  @override
  Future<QuestionnaireEntity> fetchFirstQuestion() async {
    try {
      QuerySnapshot<QuestionnaireEntity> querySnapshot = await _firestore
          .collection(CollectionConstants.questionnaire)
          .withConverter<QuestionnaireEntity>(
            fromFirestore: (snapshot, _) =>
                QuestionnaireEntity.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .orderBy(QuestionnaireEntityJsonKey.id, descending: false)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        throw DataNotExistsException();
      }
    } on FirebaseException catch (e) {
      throw DataFetchException(e.code, e.stackTrace);
    }
  }

  @override
  Future<List<QuestionnaireEntity?>> fetchQuestionnaire() async {
    try {
      QuerySnapshot<QuestionnaireEntity> querySnapshot = await _firestore
          .collection(CollectionConstants.questionnaire)
          .withConverter<QuestionnaireEntity>(
            fromFirestore: (snapshot, _) =>
                QuestionnaireEntity.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .orderBy(QuestionnaireEntityJsonKey.id, descending: false)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((e) => e.data()).toList();
      } else {
        throw DataNotExistsException();
      }
    } on FirebaseException catch (e) {
      throw DataFetchException(e.code, e.stackTrace);
    }
  }

  /// This API belongs to admin...
  @override
  Future<bool> createNewAssessment({
    required String photoUrl,
    required String question,
    required List<String> options,
  }) async {
    int id = Timestamp.now().millisecondsSinceEpoch;
    QuestionnaireEntity questionnaireEntity = QuestionnaireEntity(
      id: id,
      photoUrl: photoUrl,
      question: question,
      options: options,
    );

    CollectionReference questionnaireRef =
        _firestore.collection(CollectionConstants.questionnaire);
    CollectionReference metaRef =
        _firestore.collection(CollectionConstants.metaRef);

    try {
      await questionnaireRef
          .doc(id.toString())
          .set(questionnaireEntity.toJson(), SetOptions(merge: true));
      var questionnaireMetaDoc =
          await metaRef.doc(DocumentConstants.metaDoc).get();
      if (questionnaireMetaDoc.exists) {
        await metaRef.doc(DocumentConstants.metaDoc).update(
          {
            MetaJsonKey.count: FieldValue.increment(1),
          },
        );
      } else {
        await metaRef.doc(DocumentConstants.metaDoc).set(
              MetaDoc.init.toJson(),
              SetOptions(merge: true),
            );
      }
      return true;
    } on FirebaseException catch (e) {
      throw DataStoreException(e.stackTrace);
    }
  }

  @override
  Future<List<UserQuestionnaireResponse>?> fetchUserResponse() async {
    try {
      QuerySnapshot<UserQuestionnaireResponse> querySnapshot = await _firestore
          .collection(CollectionConstants.user)
          .doc(_auth.currentUser!.uid)
          .collection(CollectionConstants.questionnaireResponses)
          .withConverter<UserQuestionnaireResponse>(
            fromFirestore: (snapshot, _) =>
                UserQuestionnaireResponse.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((e) => e.data()).toList();
      } else {
        throw DataNotExistsException();
      }
    } on FirebaseException catch (e) {
      throw DataFetchException(e.code, e.stackTrace);
    }
  }

  @override
  Future<bool> submitUserResponse(UserQuestionnaireResponse res) async {
    try {
      CollectionReference userRef =
          _firestore.collection(CollectionConstants.user);
      CollectionReference userMetaRef = userRef
          .doc(_auth.currentUser!.uid)
          .collection(CollectionConstants.userMetaRef);
      await userRef
          .doc(_auth.currentUser!.uid)
          .collection(CollectionConstants.questionnaireResponses)
          .doc()
          .set(res.toJson(), SetOptions(merge: true));

      DocumentSnapshot userMetaDoc =
          await userMetaRef.doc(DocumentConstants.metaQuestionnaireDoc).get();
      if (userMetaDoc.exists) {
        await userMetaRef.doc(DocumentConstants.metaQuestionnaireDoc).update(
          {
            MetaJsonKey.questionnaireResponseCount: FieldValue.increment(1),
          },
        );
      } else {
        await userMetaRef.doc(DocumentConstants.metaQuestionnaireDoc).set(
              UserMetaDoc.initWith(firstQuestionId: res.questionId).toJson(),
              SetOptions(merge: true),
            );
      }

      return true;
    } on FirebaseException catch (e) {
      throw DataStoreException(e.stackTrace);
    }
  }

  @override
  String getUserId() {
    return _auth.currentUser!.uid;
  }
}
