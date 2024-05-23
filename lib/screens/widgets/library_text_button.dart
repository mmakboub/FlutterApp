import 'package:library_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LibraryTextButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final double height, width, radius;
  final Color color;
  final double labelSize;
  final Gradient? gradient;

  const LibraryTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = mainColor,
    this.height = 45,
    this.width = 120,
    this.labelSize = 20,
    this.radius = 15,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          gradient: gradient,
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: white,
              fontSize: labelSize,
            ),
          ),
        ),
      ),
    );
  }
}
