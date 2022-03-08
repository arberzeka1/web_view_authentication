import 'package:flutter/material.dart';
import 'package:web_view_authentication/constants/colors.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final String? buttonTitle;
  final void Function()? onTap;

  const MainButton({
    Key? key,
    this.buttonTitle,
    this.width,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: primarySwatch,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonTitle!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
