import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  final IconData iconData;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        width: 50,
        height: 50,
        child: IconButton(
          icon: Icon(
            iconData,
            size: 20,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
