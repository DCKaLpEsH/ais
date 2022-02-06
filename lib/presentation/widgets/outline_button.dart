import 'package:flutter/material.dart';
import 'package:gold_india_stocks/common/constants.dart';

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Constants.btnBlue,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 14.0,
        ),
        child: Text(
          "All",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
