import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:email_validator/email_validator.dart';

class EmailModel {
  ValueNotifier<String> _email;
  ValueNotifier<bool> _isEmailValid;
  ValueNotifier<String> _emails;

  EmailModel({
    required ValueNotifier<String> email,
    required ValueNotifier<bool> isEmailValid,
    required ValueNotifier<String> emails,
  })  : _email = email,
        _isEmailValid = isEmailValid,
        _emails = emails;

  ValueNotifier<String> get email => _email;
  ValueNotifier<String> get emails => _emails;
  ValueNotifier<bool> get isEmailValid => _isEmailValid;

  set email(ValueNotifier<String> email) {
    _email = email;
    _isEmailValid.value = checkIfEmailIsValid();
  }

  set emails(ValueNotifier<String> emails) {
    _emails = emails;
  }

  set isEmailValid(ValueNotifier<bool> isEmailValid) {
    _isEmailValid = isEmailValid;
  }

  bool checkIfEmailIsValid() {
    isEmailValid.value = EmailValidator.validate(email.value);
    return isEmailValid.value;
  }

  Future<String?> readEmailText() async {
    try {
      final Directory? directory = await getDownloadsDirectory();
      if (directory == null) {
        return null;
      }
      final File file = File('${directory.path}/emails.txt');
      emails.value = await file.readAsString();
      return emails.value;
    } catch (e) {
      return null;
    }
  }

  // email was saved or not
  Future<bool> saveEmailAsTxtAndSetText() async {
    try {
      final Directory? directory = await getDownloadsDirectory();
      if (directory == null) {
        return false;
      }
      final String? newEmails = await readEmailText();

      // save txt
      final File file = File('${directory.path}/emails.txt');
      await file.writeAsString('$newEmails\n${email.value}');
      email.value = "";

      // set the emails text to show new emails
      emails.value = await readEmailText() ?? newEmails ?? "";
      return true;
    } catch (e) {
      return false;
    }
  }
}
