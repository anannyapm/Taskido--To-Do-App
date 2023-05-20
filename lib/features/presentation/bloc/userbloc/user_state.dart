abstract class UserState {}

class LoginInitial extends UserState {}

class LoginSucess extends UserState {}

class LoginFailure extends UserState {
   final String errorMessage;

  LoginFailure(this.errorMessage);
}



class SignupInitial extends UserState {}

class SignupSuccess extends UserState {}

class SignupFailure extends UserState {
  final String errorMessage;

  SignupFailure(this.errorMessage);
}


class SignOut extends UserState{}