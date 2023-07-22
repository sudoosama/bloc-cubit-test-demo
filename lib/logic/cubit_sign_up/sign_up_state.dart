
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpLoaderState extends SignUpState {
  final bool isLoading;

  SignUpLoaderState(this.isLoading);
  @override
  List<Object?> get props => [isLoading];
}

class SignUpSuccessState extends SignUpState {
  final bool isSuccess;

  SignUpSuccessState(this.isSuccess);

  @override
  List<Object?> get props => [isSuccess];
}

class SignUpErrorState extends SignUpState {
  final bool isError;

  SignUpErrorState(this.isError);

  @override
  List<Object?> get props => [isError];
}
