import 'package:chronoscope/constants/colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final double shrinkScale;

  const SubmitButton({
    required this.text,
    required this.onPressed,
    this.shrinkScale = 0.995,
    super.key,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
        });
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.shrinkScale,
        ).animate(_controller),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: accentColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
