import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      margin: const EdgeInsets.symmetric(horizontal: 48),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(
                0,
                5,
              ),
              blurRadius: 4.0,
              spreadRadius: 2.0,
            )
          ]),
      child: child,
    );
  }
}
