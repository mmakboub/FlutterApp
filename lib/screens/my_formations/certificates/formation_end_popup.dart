import 'package:flutter/material.dart';
import 'package:library_app/screens/widgets/library_text_button.dart';
import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';

class FormationEndPopUp extends StatelessWidget {
  const FormationEndPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: AssetImage(
                Assets.imagify(
                  "box_bg",
                ),
              ),
            ),
            color: white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF009EE9),
                child: Icon(
                  Icons.check,
                  color: white,
                  size: 40,
                ),
              ),
              const Text(
                "Félicitations, vous avez terminé la formation avec succès",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const Text(
                "Cliquez \"D’accord\" pour remplir le formulaire de demande de certificat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              LibraryTextButton(
                label: "D'accord",
                width: 120,
                height: 50,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}
