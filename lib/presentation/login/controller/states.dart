abstract class LoginUserStates {}

class LoginUserInitState extends LoginUserStates {}

class LoginUserLoadingState extends LoginUserStates {}

class LoginUserSuccessState extends LoginUserStates {}

class LoginUserErrorState extends LoginUserStates {
  final String message;
  LoginUserErrorState(this.message);
}

class ChangeVisibilityPasswordState extends LoginUserStates {}
