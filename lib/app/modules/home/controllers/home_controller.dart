import 'package:firebase_note/app/data/models/user_model.dart';
import 'package:get/get.dart';
import '../../../data/models/note_model.dart';
import '../../../services/database.dart';
import '../../../utils/constans/constan.dart';

class HomeController extends GetxController {
// Stream data user
  Stream<UserModel?> fetchUser() {
    try {
      var snapshot = Database().streamDataUser(auth.currentUser!.uid);
      return snapshot;
    } catch (e) {
      print(e);
      errorMsg(e.toString());
      rethrow;
    }
  }

// Coba stream data list nya
  Stream<List<NoteModel>> fetchListNote() {
    try {
      var snapshot = Database().streamDataListNote(auth.currentUser!.uid);
      return snapshot;
    } catch (e) {
      errorMsg(e.toString());
      rethrow;
    }
  }

// Coba langsung stream data dari dalam list nya
  Stream<NoteModel> fetchNote() {
    try {
      var snapshot = Database().streamDataNote(auth.currentUser!.uid);
      return snapshot;
    } catch (e) {
      errorMsg(e.toString());
      rethrow;
    }
  }

  Future<void> deleteNote(String docID) async {
    try {
      await Database().deleteNote(auth.currentUser!.uid, docID);
    } catch (e) {
      errorMsg(e.toString());
    }
  }
}
