class SignupWithEmailPasswordFailure {
  final String message;

  SignupWithEmailPasswordFailure(
      [this.message = 'An unknown error has occured']);

  factory SignupWithEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignupWithEmailPasswordFailure(
            'The password provided is too weak.');
      case 'email-already-in-use':
        return SignupWithEmailPasswordFailure(
            'The account already exists for that email.');
      case 'invalid-email':
        return SignupWithEmailPasswordFailure(
            'The email address is badly formatted.');
      case 'operation-not-allowed':
        return SignupWithEmailPasswordFailure(
            'Email & Password accounts are not enabled.');
      case 'too-many-requests':
        return SignupWithEmailPasswordFailure(
            'Too many requests. Try again later.');
      case 'user-disabled':
        return SignupWithEmailPasswordFailure(
            'The user account has been disabled by an administrator.');
      default:
        return SignupWithEmailPasswordFailure();
    }
  }
}
