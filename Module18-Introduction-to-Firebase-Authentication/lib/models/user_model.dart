import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool isEmailVerified;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final String? phoneNumber;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.isEmailVerified = false,
    this.creationTime,
    this.lastSignInTime,
    this.phoneNumber,
  });

  // Create UserModel from Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      isEmailVerified: user.emailVerified,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
      phoneNumber: user.phoneNumber,
    );
  }

  // Create UserModel from Map (for Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      isEmailVerified: map['isEmailVerified'] ?? false,
      creationTime: map['creationTime'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['creationTime'])
          : null,
      lastSignInTime: map['lastSignInTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastSignInTime'])
          : null,
      phoneNumber: map['phoneNumber'],
    );
  }

  // Convert UserModel to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isEmailVerified': isEmailVerified,
      'creationTime': creationTime?.millisecondsSinceEpoch,
      'lastSignInTime': lastSignInTime?.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
    };
  }

  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    bool? isEmailVerified,
    DateTime? creationTime,
    DateTime? lastSignInTime,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      creationTime: creationTime ?? this.creationTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // Get user's first name
  String get firstName {
    if (displayName == null || displayName!.isEmpty) {
      return 'User';
    }
    return displayName!.split(' ').first;
  }

  // Get user's initials
  String get initials {
    if (displayName == null || displayName!.isEmpty) {
      return 'U';
    }
    final names = displayName!.split(' ');
    if (names.length == 1) {
      return names[0][0].toUpperCase();
    }
    return '${names[0][0]}${names[1][0]}'.toUpperCase();
  }

  // Check if user has profile photo
  bool get hasPhoto => photoURL != null && photoURL!.isNotEmpty;

  // Get display name or email as fallback
  String get displayNameOrEmail {
    if (displayName != null && displayName!.isNotEmpty) {
      return displayName!;
    }
    return email ?? 'Unknown User';
  }

  // Check if account is new (created within last 5 minutes)
  bool get isNewAccount {
    if (creationTime == null) return false;
    final now = DateTime.now();
    final difference = now.difference(creationTime!);
    return difference.inMinutes < 5;
  }

  // Get account age in days
  int get accountAgeInDays {
    if (creationTime == null) return 0;
    final now = DateTime.now();
    return now.difference(creationTime!).inDays;
  }

  // Check if user signed in recently (within last hour)
  bool get signedInRecently {
    if (lastSignInTime == null) return false;
    final now = DateTime.now();
    final difference = now.difference(lastSignInTime!);
    return difference.inHours < 1;
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, isEmailVerified: $isEmailVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}
