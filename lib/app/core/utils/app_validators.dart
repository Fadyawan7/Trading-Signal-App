class AppValidators {
  static String? validateName(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Name is required.';
    }
    if (input.length > 255) {
      return 'Name must be 255 characters or less.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Email is required.';
    }

    const pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    if (!RegExp(pattern).hasMatch(input)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    if (input.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(input)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(input)) {
      return 'Password must contain at least one number.';
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(input)) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value, {
    required String password,
  }) {
    if ((value ?? '').isEmpty) {
      return 'Confirm password is required.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'OTP is required.';
    }
    if (input.length != 6) {
      return 'OTP must be 6 digits.';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(input)) {
      return 'OTP must contain only digits.';
    }
    return null;
  }
}
