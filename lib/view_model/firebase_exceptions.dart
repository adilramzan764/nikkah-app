class SignUpEmailPasswordFailure {
  final String message;

  const SignUpEmailPasswordFailure([this.message = "An Unknown error occurred"]);

  factory SignUpEmailPasswordFailure.code(String code) {
    switch(code) {
      case 'weak-password' :
        return const SignUpEmailPasswordFailure(
          'Please enter a stronger password.',
        );
      case 'invalid-email' :
        return const SignUpEmailPasswordFailure(
          'Email in not valid or badly formatted.',
        );
      case 'email-already-in-use' :
        return const SignUpEmailPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed' :
        return const SignUpEmailPasswordFailure(
          'Operations is not allowed. Please contact support.',
        );
      case 'user-disabled' :
        return const SignUpEmailPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      default:
        return const SignUpEmailPasswordFailure();
    }
  }
}

class SignInEmailPasswordFailure {
  final String message;

  const SignInEmailPasswordFailure([this.message = "An Unknown error occurred"]);

  factory SignInEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const SignInEmailPasswordFailure(
          'No user found for that email.',
        );
      case 'wrong-password':
        return const SignInEmailPasswordFailure(
          'Wrong password provided for that user.',
        );
      case 'operation-not-allowed':
        return const SignInEmailPasswordFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'invalid-email':
        return const SignInEmailPasswordFailure(
          'The email address is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInEmailPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      default:
        return const SignInEmailPasswordFailure();
    }
  }
}

class SignInGoogleFailure {
  final String message;

  const SignInGoogleFailure([this.message = "An unknown error occurred"]);

  factory SignInGoogleFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const SignInGoogleFailure(
          'No user found for that email.',
        );
      case 'wrong-password':
        return const SignInGoogleFailure(
          'Wrong password provided for that user.',
        );
      case 'invalid-verification-code':
        return const SignInGoogleFailure(
          'The verification code is not valid.',
        );
      case 'invalid-verification-id':
        return const SignInGoogleFailure(
          'The verification ID is not valid.',
        );
      case 'invalid-credential':
        return const SignInGoogleFailure(
          'The credential is not valid or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInGoogleFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'account-exists-with-different-credential':
        return const SignInGoogleFailure(
          'An account already exists with a different credential.',
        );
      case 'user-disabled':
        return const SignInGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      default:
        return const SignInGoogleFailure();
    }
  }
}

class LoginWithFacebookFailure {
  final String message;

  const LoginWithFacebookFailure([this.message = "An unknown error occurred"]);

  factory LoginWithFacebookFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginWithFacebookFailure(
          'No user found for that credential.',
        );
      case 'wrong-password':
        return const LoginWithFacebookFailure(
          'Wrong password provided.',
        );
      case 'invalid-verification-code':
        return const LoginWithFacebookFailure(
          'The verification code is invalid.',
        );
      case 'invalid-verification-id':
        return const LoginWithFacebookFailure(
          'The verification ID is invalid.',
        );
      case 'invalid-credential':
        return const LoginWithFacebookFailure(
          'The credential is invalid or expired.',
        );
      case 'operation-not-allowed':
        return const LoginWithFacebookFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'account-exists-with-different-credential':
        return const LoginWithFacebookFailure(
          'An account already exists with a different credential.',
        );
      case 'user-disabled':
        return const LoginWithFacebookFailure(
          'This user has been disabled. Please contact support for help.',
        );
      default:
        return const LoginWithFacebookFailure();
    }
  }
}