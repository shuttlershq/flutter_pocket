import 'package:flutter/material.dart';

class InfoUpdateState extends StatelessWidget {
  const InfoUpdateState({
    Key? key,
    required this.message,
    required this.onReload,
    required this.description,
  }) : super(key: key);
  final String message;
  final String description;
  final Function() onReload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            label: 'I have made payment',
            onPressed: onReload,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.label,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF000005),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      style: TextButton.styleFrom(
        primary: Colors.transparent,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(
          color: Color(0xFFE5E9F2),
          width: 1,
        ),
      ),
    );
  }
}
