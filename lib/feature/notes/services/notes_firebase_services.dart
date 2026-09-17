import 'package:cloud_firestore/cloud_firestore.dart';

class NotesServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String title, String description) async {
    await _firestore.collection("notes").doc().set({
      "title": title,
      "description": description,
    });
  }

  Future<void> deleteNote(String id) async {
    _firestore.collection("notes").doc(id).delete();
  }

  Future<void> updateNote(String title, String description, String id) async {
    await _firestore.collection("notes").doc(id).update({
      "title": title,
      "description": description,
    });
  }
}
