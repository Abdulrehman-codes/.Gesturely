
class SignupWithEmailAndPasswordFailure {
  final String message;

  const SignupWithEmailAndPasswordFailure([this.message='An Unknown error has occured']);

  factory SignupWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignupWithEmailAndPasswordFailure('Please Enter a Stronger Password');
      case 'invalid-email':
        return const SignupWithEmailAndPasswordFailure('Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignupWithEmailAndPasswordFailure('An account already exists for that email');
      case 'operation-not-allowed':
        return const SignupWithEmailAndPasswordFailure('Operation is not allowed. Please Contact support');
      case 'user-disabled':
        return const SignupWithEmailAndPasswordFailure('This user has been disabled. Please Contact support');
      default:
        return const SignupWithEmailAndPasswordFailure();
    }
  }
}