import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({
    Key? key,
    required this.onTap,
    required this.btnTitle,
    required this.btnColor,
  }) : super(key: key);
  final VoidCallback onTap;
  final String btnTitle;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: btnColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 14.0,
        ),
        child: Text(
          btnTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
