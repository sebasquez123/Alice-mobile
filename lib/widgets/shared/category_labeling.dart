import 'package:flutter/material.dart';

class CategoryLabelingWidget extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final double fontSize;
  final EdgeInsets padding;
  final double borderRadius;
  final double chipSpacing;

  const CategoryLabelingWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.activeColor = const Color(0xFF531900),
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = const Color(0xFF531900),
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.borderRadius = 20.0,
    this.chipSpacing = 3.0,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onCategorySelected(null),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: selectedCategory == null ? activeColor : inactiveColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Text(
                  'Todos',
                  style: TextStyle(
                    color: selectedCategory == null ? activeTextColor : inactiveTextColor.withAlpha(153),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(width: chipSpacing),
            ...categories.map((category) => GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: chipSpacing),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: selectedCategory == category ? activeColor : inactiveColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: selectedCategory == category ? activeTextColor : inactiveTextColor.withAlpha(153),
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      );
}
