import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddOptions extends StatelessWidget {
  final Function onShare;
  final Function onQuote;

  const AddOptions({
    super.key,
    required this.onShare,
    required this.onQuote,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: GestureDetector(
          onTap: () => onShare(),
          child: SvgPicture.asset(
            shareIcon,
            width: 25,
            colorFilter: const ColorFilter.mode(
              Color(0xFF531900),
              BlendMode.srcIn))
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10,right: 5),
        child: Text(
          'Product available!',
          style: TextStyle(
            color: ColorProvider.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    ],
    ),
    );
}