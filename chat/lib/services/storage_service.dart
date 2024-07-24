import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserPfp({
    required File file,
    required String uid,
  }) async {
    Reference fileRef =
        _firebaseStorage.ref().child('users').child('pfps').child(uid);
    UploadTask task = fileRef.putFile(
        File(file.path), SettableMetadata(contentType: 'image/jpeg'));
    return task.then(
      (p) {
        if (p.state == TaskState.success) {
          return fileRef.getDownloadURL();
        }
      },
    );
  }
}
