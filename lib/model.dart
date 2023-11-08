import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';

class EmailModel {
  TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController emailController) {
    _emailController = emailController;
  }

  bool isEmailValid() {
    return EmailValidator.validate(_emailController.text);
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
      await file.writeAsString(emails != null ? '$emails\n${_emailController.text}' : _emailController.text);
      _emailController.text = "";
      return true;
    } catch (e) {
      return false;
    }
  }
}
