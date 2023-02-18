import 'dart:convert';

import 'package:equatable/equatable.dart';

enum UserRank {
  bronze,
  silver,
  gold;
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final int point;
  final UserRank rank;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.point,
    this.rank = UserRank.bronze, //default
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      profileImageUrl,
      point,
      rank,
    ];
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, profileImageUrl: $profileImageUrl, point: $point, rank: $rank)';
  }

  
}
