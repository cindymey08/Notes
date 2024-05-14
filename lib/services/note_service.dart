import 'package:cloud_firestore/cloud_firestore.dart';

class NoteSrevice {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection =
      _database.collection('notes');

  static Future<void> addNotes(String title, String description) async {
    
    Map<String, dynamic> newNote = {
      'title': title,
      'descpription': description,
    };
    await _notesCollection.add(newNote);
  }

  static Future<void> updateNote(
      String id, String title, String description) async {
    Map<String, dynamic> updateNote = {
      'title': title,
      'descpription': description,
    };
    await _notesCollection.doc(id).update(updateNote);
  }

  static Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }

  static Stream<List<Map<String, dynamic>>> getNoteList() {
    return _notesCollection.snapshots().map((querysnapshot){
      return querysnapshot.docs.map((docSnapshot){
        final data = docSnapshot.data() as Map<String,dynamic>;
        return{'id':docSnapshot.id, ...data};
      }).toList();
     });
  }
}
