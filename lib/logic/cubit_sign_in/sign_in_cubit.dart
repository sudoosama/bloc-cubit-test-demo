import 'package:demo_new/data/user_data_repository.dart';
import 'package:demo_new/logic/cubit_sign_in/sign_in_state.dart';
import 'package:demo_new/widget/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(SignInState initialState) : super(initialState);

  Future<bool> signIn(
      BuildContext context, String email, String password) async {
    bool isSuccess = false;
    final _auth = FirebaseAuth.instance;
    emit(SignInLoaderState(true));
    try {
      final signInUserInfo = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccessState(true));
      UserDataRepository().storeUserData(signInUserInfo.user!.uid);
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      MyShowSnackBar.errorSnackBar(context, e.message.toString());
      emit(SignInErrorState(true));
      isSuccess = false;
    } finally {
      emit(SignInLoaderState(false));
    }
    return isSuccess;
  }
}
