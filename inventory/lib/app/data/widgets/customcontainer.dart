import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.width, this.text,this.onTap});
  final double? width;
  final String? text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap:onTap,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(border: Border.all()),
          child: Center(child: Text(text ?? "")),
        ),
      ),
    );
  }
}
