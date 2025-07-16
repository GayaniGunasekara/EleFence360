import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String contactNo;
  final String nic;
  final String address;
  final String profileImage;

  UserProfile({
    required this.name,
    required this.contactNo,
    required this.nic,
    required this.address,
    required this.profileImage,
  });
}

class UserProvider extends ChangeNotifier {
  UserProfile _userProfile = UserProfile(
    name: 'Lalitha Kumari',
    contactNo: '071-7512345',
    nic: '658926134V',
    address: 'No.125, Hospital Road, Galgamuwa',
    profileImage: 'assets/profile_pic.jpg',
  );

  UserProfile get userProfile => _userProfile;

  void updateUserProfile(UserProfile newProfile) {
    _userProfile = newProfile;
    notifyListeners();
  }
}