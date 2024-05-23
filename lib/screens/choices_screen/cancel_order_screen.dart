import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CancelOrderScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final InputDecoration _inputDecoration = const InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
  );
  CancelOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Leave a comment",
              style: TextStyle(
                color: darkGrey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              minLines: 2,
              maxLines: 5,
              controller: _commentController,
              decoration: _inputDecoration,
              validator: (String? value) {
                if (value == null || value.isEmpty || value.length < 8) {
                  return 'Please enter a valid comment!';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                LibraryTextButton(
                  label: "Back",
                  color: grey,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: 135,
                ),
                const SizedBox(width: 30),
                LibraryTextButton(
                  label: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: red,
                  width: 135,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
