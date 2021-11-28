import 'package:flutter_test/flutter_test.dart';

import 'package:mebook/widgets/authentication/validators.dart';

void main() {
  String validation;
  test('email validations', () {
    validation = FieldValidators.validateEmail("");
    expect(validation == null, false);

    validation = FieldValidators.validateEmail("mock-email");
    expect(validation == null, false);

    validation = FieldValidators.validateEmail("mock-email@mail.com");
    expect(validation == null, true);
  });

  test('username validations', () {
    validation = FieldValidators.validateUsername("");
    expect(validation == null, false);

    validation = FieldValidators.validateUsername("abc");
    expect(validation == null, false);

    validation = FieldValidators.validateUsername("mock-username");
    expect(validation == null, true);
  });

  test('password validations', () {
    validation = FieldValidators.validatePassword("");
    expect(validation == null, false);

    validation = FieldValidators.validatePassword("abc-de");
    expect(validation == null, false);

    validation = FieldValidators.validatePassword("mock-password");
    expect(validation == null, true);
  });
}