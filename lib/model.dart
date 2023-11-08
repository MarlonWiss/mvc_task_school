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

  // email was saved or not
  Future<bool> saveEmailAsTxt() async {
    try {
      final Directory? directory = await getDownloadsDirectory();
      if (directory != null) {
        final File file = File(
          '${directory.path}/$_email.txt',
        );
        await file.writeAsString(_email);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
