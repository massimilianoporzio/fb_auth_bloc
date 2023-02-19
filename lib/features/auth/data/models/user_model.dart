import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.profileImageUrl,
      required super.point,
      super.rank});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'profileImageUrl': profileImageUrl});
    result.addAll({'point': point});
    result.addAll({'rank': rank.name});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        profileImageUrl: map['profileImageUrl'] ?? '',
        point: map['point']?.toInt() ?? 0,
        rank: UserRank.values.byName(map['rank']));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    int? point,
    UserRank? rank,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      point: point ?? this.point,
      rank: rank ?? this.rank,
    );
  }

  factory UserModel.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;
    //*riassegno id dal userDoc.id

    return UserModel.fromMap(userData!).copyWith(id: userDoc.id);
  }
  //NON NULL FIELDS BUT USELESS
  //USed when no data are yet available from the Server
  factory UserModel.initial() {
    return const UserModel(
      id: '',
      name: '',
      email: '',
      profileImageUrl: '',
      point: -1,
    );
  }
}
