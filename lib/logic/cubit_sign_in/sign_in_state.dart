import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class SignInInitState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInLoaderState extends SignInState {
  final bool isLoading;

  SignInLoaderState(this.isLoading);
  @override
  List<Object?> get props => [isLoading];
}

class SignInSuccessState extends SignInState {
  final bool isSuccess;

  SignInSuccessState(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class SignInErrorState extends SignInState {
  final bool isError;

  SignInErrorState(this.isError);

  @override
  List<Object?> get props => [isError];
}
