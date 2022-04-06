import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note/app/data/models/note_model.dart';
import '../data/models/user_model.dart';
import '../utils/constans/constan.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> setUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.id).set(
          // jadi beginisi
          user.toJson()

          // asalnya begini karena paketo toJson()

          //   {
          //   'id': user.id,
          //   'name': user.name,
          //   'phone': user.phone,
          //   'email': user.email,
          //   'createdAt': user.createdAt,
          // }
          );
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(id).get();

      return UserModel.fromJson(id, snapshot.data() as Map<String, dynamic>);

      // Asal nya begini

      // return UserModel(
      //   id: id,
      //   name: snapshot['name'],
      //   phone: snapshot['phone'],
      //   email: snapshot['email'],
      //   createdAt: snapshot['createdAt'],
      // );

    } catch (e) {
      // print(e);
      // errorMsg(e.toString());
      rethrow;
    }
  }

  // stream documentSnapshot tanpa model
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser(String id) async* {
    try {
      yield* firestore.collection('users').doc(id).snapshots();
    } catch (e) {
      print(e);
    }
  }

  // stream documentSnapshot dengan model
  Stream<UserModel?> streamDataUser(String id) {
    return firestore.collection('users').doc(id).snapshots().map(
          (DocumentSnapshot<Map<String, dynamic>> snapshot) =>
              UserModel.fromJson(
            id,
            snapshot.data()!,
          ),
        );
  }

  Future<void> updateUser(String id, String name, String phone) async {
    await firestore.collection('users').doc(id).update(
      {'name': name, 'phone': phone},
    );
  }

  Stream<NoteModel> streamDataNote(String id) async* {
    try {
      yield* firestore
          .collection('users')
          .doc(id)
          .collection('notes')
          .doc(id)
          .snapshots()
          .map(
            (DocumentSnapshot<Map<String, dynamic>> snapshot) =>
                NoteModel.fromJson(
              id,
              snapshot.data()!,
            ),
          );
    } catch (e) {
      // print(e);
      // errorMsg(e.toString());
      rethrow;
    }
  }

  Stream<List<NoteModel>> streamDataListNote(String id) async* {
    try {
      yield* firestore
          .collection('users')
          .doc(id)
          .collection('notes')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map(
                (document) => NoteModel.fromJson(
                  document.id,
                  document.data(),
                ),
              )
              .toList());
    } catch (e) {
      // print(e);
      // errorMsg(e.toString());
      rethrow;
    }
  }

  Future<void> setNote(NoteModel note) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('notes')
          .add(note.toJson()
              //       {
              //   'id': note.id,
              //   'title': note.title,
              //   'desc': note.desc,
              //   'createdAt': note.createdAt
              // }

              );
    } catch (e) {
      print(e);
      // errorMsg(e.toString());
    }
  }

  Future<void> updateNote(String id, String title, String desc) async {
    try {
      await firestore
          .collection('users')
          .doc(id)
          .collection('notes')
          .doc(id)
          .update(
        {
          'title': title,
          'desc': desc,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNote(String id, String docID) async {
    try {
      await firestore
          .collection('users')
          .doc(id)
          .collection('notes')
          .doc(docID)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<NoteModel> getNoteById(String id) async {
    try {
      DocumentSnapshot snapshot = await firestore
          .collection('users')
          .doc(id)
          .collection('notes')
          .doc(id)
          .get();

      return NoteModel.fromJson(id, snapshot.data() as Map<String, dynamic>);

      // Asal nya begini

      // return UserModel(
      //   id: id,
      //   name: snapshot['name'],
      //   phone: snapshot['phone'],
      //   email: snapshot['email'],
      //   createdAt: snapshot['createdAt'],
      // );

    } catch (e) {
      // print(e);
      // errorMsg(e.toString());
      rethrow;
    }
  }
}
