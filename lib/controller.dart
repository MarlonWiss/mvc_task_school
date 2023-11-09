import 'package:mvc_task_school/model.dart';

class EmailController {
  final EmailModel _emailModel;

  EmailController({
    required EmailModel emailModel,
  }) : _emailModel = emailModel;

  // email was saved or not
  Future<bool> saveEmail() async {
    return await _emailModel.saveEmailAsTxtAndSetText();
  }
}
