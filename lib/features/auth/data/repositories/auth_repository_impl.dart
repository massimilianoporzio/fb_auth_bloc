import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/db_constants.dart';
import '../models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  @override
  Future<Either<Failure, Unit>> signin(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right(unit);
    } on fbAuth.FirebaseAuthException catch (authError) {
      return Left(
        FirebaseFailure(
          code: authError.code,
          message: authError.message!,
          plugin: authError.plugin,
        ),
      );
    } on Exception {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedInUser = userCredential.user!;
      //create document inside users collection
      UserModel mySignedInUser = UserModel.initial().copyWith(
          name: name,
          email: email,
          point: 0,
          profileImageUrl: 'https://picsum.photos/300' //random image
          );
      await userRef.doc(signedInUser.uid).set(mySignedInUser.toMap());
      return const Right(unit);
    } on fbAuth.FirebaseAuthException catch (authError) {
      return Left(
        FirebaseFailure(
          code: authError.code,
          message: authError.message!,
          plugin: authError.plugin,
        ),
      );
    } on Exception {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signout() async {
    try {
      await firebaseAuth.signOut();
      return const Right(unit);
    } on Exception {
      return Left(LogoutFailure());
    }
  }
}
