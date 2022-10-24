import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickstartmyheart/services/cloud/cloud_note.dart';
import 'package:kickstartmyheart/services/cloud/cloud_storage_constants.dart';
import 'package:kickstartmyheart/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {

  final notes = FirebaseFirestore.instance.collection('notes');

  // Singleton Pattern
  static final FirebaseCloudStorage _shared =
  FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance(); // Private Constructor
  factory FirebaseCloudStorage() => _shared; // Factory Constructor

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetchedNote = await document.get();
    return CloudNote(
      documentId: fetchedNote.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) {
    final allNotes = notes.where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs
        .map((doc) => CloudNote.fromSnapshot(doc)));
    return allNotes;
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }
}