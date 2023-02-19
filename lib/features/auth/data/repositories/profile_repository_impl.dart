import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/core/utils/db_constants.dart';
import 'package:fb_auth_bloc/features/auth/domain/entities/user.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/profile_repository.dart';

import '../models/user_model.dart';

class ProfileRepoImpl implements ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepoImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<Either<Failure, User>> getProfile({required String uid}) async {
    try {
      //chiedo il document relativo all'uid
      final DocumentSnapshot userDoc = await userRef.doc(uid).get();
      if (userDoc.exists) {
        final currentUser = UserModel.fromDoc(userDoc);
        return Right(currentUser);
      } else {
        return Left(UserNotFoundFailure());
      }
    } on FirebaseException catch (fe) {
      return Left(FirebaseFailure(
          code: fe.code, message: fe.message!, plugin: fe.plugin));
    } on Exception catch (e) {
      return Left(GenericFailure());
    }
  }
}
