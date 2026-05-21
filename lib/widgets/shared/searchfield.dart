import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? searchController;
  final FocusNode searchFocusNode;
  final bool hasText;
  final VoidCallback? onClear;
  final String hintText;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;

  const SearchField({
    super.key,
    this.searchController,
    required this.searchFocusNode,
    this.hasText = false,
    this.onClear,
    this.hintText = 'Search',
    this.primaryColor = const Color(0xFF531900),
    this.accentColor = const Color(0xFFFF005D),
    this.backgroundColor = const Color(0xFFF1A1FF),
    this.borderRadius = 15.0,
    this.padding = 25.0,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: searchFocusNode.hasFocus
              ? [
                  BoxShadow(
                    color: accentColor.withAlpha(25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
        ),
        child: TextField(
          focusNode: searchFocusNode,
          controller: searchController,
          style: TextStyle(
            color: primaryColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: primaryColor.withAlpha(128),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            hintText: hintText,
            prefixIcon: Icon(
              Icons.search,
              color: searchFocusNode.hasFocus
                  ? accentColor
                  : primaryColor.withAlpha(153),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: searchFocusNode.hasFocus
                ? backgroundColor.withAlpha(35)
                : backgroundColor.withAlpha(15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor.withAlpha(25),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: accentColor,
                width: 1.5,
              ),
            ),
            suffixIcon: searchFocusNode.hasFocus && hasText
                ? GestureDetector(
                    onTap: onClear,
                    child: Icon(
                      Icons.close,
                      color: accentColor.withAlpha(179),
                      size: 24,
                    ),
                  )
                : null,
            isDense: true,
          ),
        ),
      ),
    );
}
