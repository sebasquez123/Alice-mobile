import 'package:flutter/material.dart';

class AnimatedSwitch extends StatelessWidget {
  final bool isActive;
  final Future<void> Function(BuildContext) onFirstTabTap;
  final Future<void> Function(BuildContext) onSecondTabTap;
  final String firstLabel;
  final String secondLabel;
  final Color activeColor;
  final Color inactiveColor;
  final Color shadowColor;
  final double height;
  final double fontSize;
  final double borderRadius;

  const AnimatedSwitch({
    super.key,
    required this.isActive,
    required this.onFirstTabTap,
    required this.onSecondTabTap,
    required this.firstLabel,
    required this.secondLabel,
    this.activeColor = Colors.pinkAccent,
    this.inactiveColor = Colors.transparent,
    this.shadowColor = Colors.pinkAccent,
    this.height = 40.0,
    this.fontSize = 16.0,
    this.borderRadius = 14.0,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async => await onFirstTabTap(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: shadowColor.withAlpha(75),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                firstLabel,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[600],
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: fontSize,
                  letterSpacing: isActive ? 0.5 : 0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async => await onSecondTabTap(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: !isActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
                boxShadow: !isActive
                    ? [
                        BoxShadow(
                          color: shadowColor.withAlpha(75),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                secondLabel,
                style: TextStyle(
                  color: !isActive ? Colors.white : Colors.grey[600],
                  fontWeight: !isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: fontSize,
                  letterSpacing: !isActive ? 0.5 : 0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
