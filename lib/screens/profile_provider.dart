import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileProvider extends ChangeNotifier {
  String _userName = 'Anonymous';
  String _userBio = '';
  String _profilePictureUrl = '';

  String get userName => _userName;
  String get userBio => _userBio;
  String get profilePictureUrl => _profilePictureUrl;

  void updateProfile(String name, String bio, String pictureUrl) {
    _userName = name;
    _userBio = bio;
    _profilePictureUrl = pictureUrl;
    notifyListeners();
  }

  Future<void> updateProfilePicture(File imageFile) async {
    // Generate a unique filename for the image
    final fileName = 'profile_picture_${DateTime.now().millisecondsSinceEpoch}';

    // Upload image to Firebase Storage
    final storageRef = firebase_storage.FirebaseStorage.instance.ref();
    final uploadTask = storageRef.child('profile_pictures/$fileName').putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      // Get the download URL for the uploaded image
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the profile with the new picture URL
      updateProfile(_userName, _userBio, downloadUrl);

      // Notify listeners that the profile has been updated
      notifyListeners();
    } else {
      // Error occurred while uploading image
      // You can handle the error according to your app's requirements
      throw ('Failed to upload profile picture.');
    }
  }
}
