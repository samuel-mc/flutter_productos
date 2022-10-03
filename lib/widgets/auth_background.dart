import 'package:flutter/material.dart';
import 'package:productos_app/helpers/custom_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.darkBlue,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [const _PurpleSquare(), _AuthIcon(), child],
      ),
    );
  }
}

class _AuthIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Icon(Icons.person_pin, color: Colors.white, size: 120),
      ),
    );
  }
}

class _PurpleSquare extends StatelessWidget {
  const _PurpleSquare({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        CustomColors.darkBlue,
        CustomColors.lightBlue,
      ])),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: -50,
            child: _Bubble(),
          ),
          Positioned(
            left: 220,
            top: 10,
            child: _Bubble(),
          ),
          Positioned(
            left: 75,
            bottom: 10,
            child: _Bubble(),
          ),
          Positioned(
            right: -30,
            bottom: -30,
            child: _Bubble(),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.lightPink.withAlpha(10), shape: BoxShape.circle),
      height: 120,
      width: 120,
    );
  }
}
