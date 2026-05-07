import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app/core/utils/app_validators.dart';

void main() {
  group('AppValidators.validatePassword', () {
    test('rejects short password', () {
      expect(
        AppValidators.validatePassword('Ab1@'),
        'Password must be at least 8 characters.',
      );
    });

    test('accepts valid password', () {
      expect(AppValidators.validatePassword('Abcd@1234'), isNull);
    });
  });

  group('AppValidators.validateOtp', () {
    test('rejects invalid otp', () {
      expect(AppValidators.validateOtp('123'), 'OTP must be 6 digits.');
    });

    test('accepts valid otp', () {
      expect(AppValidators.validateOtp('306878'), isNull);
    });
  });
}
