import 'package:flutter/material.dart';
import 'package:gold_india_stocks/common/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.height,
    required this.width,
    required this.searchController,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);

  final double height;
  final double width;
  final TextEditingController searchController;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.blue.withOpacity(0.2),
          width: 1.0,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(height * 0.08),
      ),
      height: height * 0.08,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.only(left: 15),
      alignment: Alignment.center,
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: "Search Client Name",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
