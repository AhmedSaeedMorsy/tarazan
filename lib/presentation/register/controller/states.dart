abstract class RegisterUserStates {}

class RegisterUserInitState extends RegisterUserStates {}

class RegisterUserLoadingState extends RegisterUserStates {}

class RegisterUserSuccessState extends RegisterUserStates {}

class RegisterUserErrorState extends RegisterUserStates {
  final String message;
  RegisterUserErrorState(this.message);
}

class ChangeVisibilityPasswordState extends RegisterUserStates {}

class ProfileImagePickedErrorState extends RegisterUserStates {}
