import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String phone;
  final String nic;
  final String address;
  final String profileImage;

  UserProfile(
    this.profileImage, {
    required this.name,
    required this.phone,
    required this.nic,
    required this.address,
  });

  // Factory constructor to create a UserProfile from a map (e.g., from Firebase Realtime Database)
  factory UserProfile.fromMap(Map<dynamic, dynamic> data) {
    return UserProfile(
      data['profileImage'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      nic: data['nic'] ?? '',
      address: data['address'] ?? '',
    );
  }

  // Convert UserProfile to map (for uploading to database)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'nic': nic,
      'address': address,
      'profileImage': 'assets/profile_pic.jpg',
    };
  }
}

class UserProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile get userProfile => _userProfile!;

  void updateUserProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }
}
