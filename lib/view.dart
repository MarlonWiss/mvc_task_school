import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_task_school/controller.dart';
import 'package:mvc_task_school/model.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  TextEditingController emailEditingController = TextEditingController();
  bool emailIsValid = false;
  
  late EmailModel emailModel;
  late EmailController emailController;

  @override
  void initState() {
    super.initState();
    emailModel = EmailModel(email: "");
    emailController = EmailController(emailModel: emailModel);
  }

  void showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("E-Mail gespeichert"),
          content: const Text("Die E-Mail wurde erfolgreich gespeichert"),
          actions: [
            FilledButton(
                onPressed:  () {
                        Navigator.of(context).pop();
                      }, child: const Text("OK"),),
          
          ],
        );
      },
    );
  }

  void showError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("E-Mail nicht gespeichert"),
          content: const Text("Die E-Mail konnte nicht gespeichert werden"),
          actions: [
            FilledButton(
                onPressed:  () {
                        Navigator.of(context).pop();
                      }, child: const Text("OK"),),
          
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBox(
              controller: emailEditingController,
              highlightColor: emailIsValid ? null : Colors.red,
              placeholder: "Bitte gebe die E-Mail ein",
              onChanged: (value) {
                emailModel.email = value;
                setState(() {
                  emailIsValid = emailModel.isEmailValid();
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: emailIsValid
                    ? () async {
                        final bool saved = await emailController.saveEmail();
                        if(saved) {
                          showMessage(context);
                        } else {
                          showError(context);
                        }
                      }
                    : null,
                child: const Text("Speichern"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
