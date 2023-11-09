import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_task_school/controller.dart';
import 'package:mvc_task_school/model.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late EmailModel emailModel;
  late EmailController emailController;
  TextEditingController emailTextController = TextEditingController();

  @override
  initState() {
    super.initState();
    emailModel = EmailModel(
      email: ValueNotifier(""),
      emails: ValueNotifier(""),
      isEmailValid: ValueNotifier(false),
    );
    emailController = EmailController(emailModel: emailModel);
  }

  @override
  void dispose() {
    emailModel.email.dispose();
    emailModel.isEmailValid.dispose();
    emailModel.emails.dispose();
    super.dispose();
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveEmail(BuildContext context) async {
    final bool saved = await emailController.saveEmail();
    if (saved) {
      emailTextController.text = "";
      showMessage(context);
    } else {
      showError(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: emailModel.isEmailValid,
              builder: (context, value, child) => TextBox(
                controller: emailTextController,
                highlightColor: value ? null : Colors.red,
                placeholder: "Bitte gebe die E-Mail ein",
                onSubmitted: value ? (_) => saveEmail(context) : null,
                onChanged: (value) {
                  emailModel.email = ValueNotifier(value);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ValueListenableBuilder(
                        valueListenable: emailModel.emails,
                        builder: (context, value, child) => Text(value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: emailModel.isEmailValid,
              builder: (context, value, child) => SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: value
                      ? () async {
                          await saveEmail(context);
                        }
                      : null,
                  child: const Text("Speichern"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
