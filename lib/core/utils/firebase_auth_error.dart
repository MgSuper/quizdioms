String getFirebaseAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-disabled':
      return 'This user has been disabled.';
    case 'user-not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'Incorrect password provided.';
    case 'email-already-in-use':
      return 'This email is already associated with another account.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'invalid-credential':
      return 'No user found with this email.';
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
