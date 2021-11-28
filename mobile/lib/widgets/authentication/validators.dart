class FieldValidators {
  static String validateEmail(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String validateUsername(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Please enter at least 4 characters.';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    return null;
  }
}