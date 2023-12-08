class GExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// {@macro log_in_with_email_and_password_failure}
  const GExceptions([this.message = 'An unknown exception occurred.']);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory GExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const GExceptions ('Email already exists.');
      case 'invalid-email':
        return const GExceptions ('Email is not valid or badly formatted.');
      case 'weak-password':
        return const GExceptions ('Please enter a stronger password. ');
      case 'user-disabled':
        return const GExceptions ('This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const GExceptions ('Invalid Details, please create an account.');
      case 'wrong-password':
        return const GExceptions ('Incorrect password, please try again.');
      case 'too-many-requests':
        return const GExceptions ('Too many requests, Service Temporarily blocked.');
      case 'invalid-argument':
        return const GExceptions ('An invalid argument was provided to an Authentication method.');
      case 'invalid-password':
        return const GExceptions ('Incorrect password, please try again.');
      case 'invalid-phone-number':
        return const GExceptions ('The provided Phone Number is invalid.');
      case 'operation-not-allowed':
        return const GExceptions('The provided sign-in provider is disabled for your Firebase project.');
      case 'session-cookie-expired':
        return const GExceptions ('The provided Firebase session cookie is expired.');
      case 'uid-already-exists':
        return const GExceptions ('The provided uid is already in use by an existing user.');
      default:
        return const GExceptions();
    }
  }
}