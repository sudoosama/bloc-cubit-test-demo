import 'package:demo_new/data/user_data_repository.dart';
import 'package:demo_new/logic/cubit_sign_up/sign_up_state.dart';
import 'package:demo_new/widget/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(SignUpState initialState) : super(initialState);

  Future<bool> register(BuildContext context,String email, String password) async {
    bool isSuccess= false;
    final _auth = FirebaseAuth.instance;
    emit(SignUpLoaderState(true));
    try {
      final signUpUserInfo = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccessState(true));
      UserDataRepository().storeUserData(signUpUserInfo.user!.uid);
      isSuccess= true;
    } on FirebaseAuthException catch (e) {
      MyShowSnackBar.errorSnackBar(context, e.message.toString());
      emit(SignUpErrorState(true));
      isSuccess= false;
    } finally {
      emit(SignUpLoaderState(false));
    }
    return isSuccess;
  }
}
