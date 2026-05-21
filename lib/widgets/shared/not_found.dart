import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String itemName;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final double boxSize;

  const NotFoundWidget({
    super.key,
    required this.itemName,
    this.boxSize = 200,
    this.icon = Icons.search_off,
    this.iconColor = Colors.grey,
    this.textColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: boxSize,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100,
                color: iconColor.withAlpha(150),
              ),
              const SizedBox(height: 10),
              Text(
                '$itemName not found',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor.withAlpha(150),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
}
