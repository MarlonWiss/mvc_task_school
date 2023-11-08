import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:email_validator/email_validator.dart';

class EmailModel {
  String _email;

  EmailModel({
    required String email,
  }) : _email = email;

  String get email => _email;

  set email(String email) {
    _email = email;
  }

  bool isEmailValid() {
    return EmailValidator.validate(_email);
  }

  Future<String?> readEmailText() async {
    try {
      final Directory? directory = await getDownloadsDirectory();
      if (directory == null) {
        return null;
      }
      final File file = File('${directory.path}/emails.txt');
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  // email was saved or not
  Future<bool> saveEmailAsTxt() async {
    try {
      final Directory? directory = await getDownloadsDirectory();
      if (directory == null) {
        return false;
      }
      final String? emails = await readEmailText();
      final File file = File('${directory.path}/emails.txt');
      await file.writeAsString(emails != null ? '$emails\n$email' : _email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
