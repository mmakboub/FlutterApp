import 'package:library_app/utils/assets.dart';
import 'package:library_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertScreen extends StatelessWidget {
  final String alertMessage;
  const AlertScreen({super.key, required this.alertMessage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 200,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: red,
            height: 60,
            width: double.infinity,
            child: SvgPicture.asset(
              Assets.iconify("alert"),
            ),
          ),
          const Spacer(),
          Text(
            alertMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: darkGrey,
              fontSize: 40,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
