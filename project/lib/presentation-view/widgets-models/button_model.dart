import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final Function() onTap;
  final double width;
  final double height;
  final bool isLoading;

  const ButtonModel({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: isLoading ? Center(child: CircularProgressIndicator(),) : Icon(Icons.import_export),
      ),
    );
  }
}
