class LoginWithEmailPasswordFailure {
  final String message;

  LoginWithEmailPasswordFailure(
      [this.message = 'An unknown error has occured']);

  factory LoginWithEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'wrong-password':
        return LoginWithEmailPasswordFailure(
            'The password is invalid or the user does not have a password.');
      case 'user-not-found':
        return LoginWithEmailPasswordFailure('No user found for that email.');
      case 'user-disabled':
        return LoginWithEmailPasswordFailure(
            'The user account has been disabled by an administrator.');
      case 'too-many-requests':
        return LoginWithEmailPasswordFailure(
            'Too many requests. Try again later.');
      case 'invalid-email':
        return LoginWithEmailPasswordFailure(
            'The email address is badly formatted.');
      case 'operation-not-allowed':
        return LoginWithEmailPasswordFailure(
            'Email & Password accounts are not enabled.');
      case 'account-exists-with-different-credential':
        return LoginWithEmailPasswordFailure(
            'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
      default:
        return LoginWithEmailPasswordFailure();
    }
  }
}
