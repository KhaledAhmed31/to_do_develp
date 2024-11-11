import 'package:flutter/material.dart';
import 'package:to_do/themes&colors/my_colors.dart';

class LogRegButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const LogRegButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 22,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: MyColors.lightBlue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
