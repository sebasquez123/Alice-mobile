import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddOptions extends StatelessWidget {
  final Function onLove;
  final Function onShare;
  final Function onQuote;
  final Function onSave;
  final int likes;

  const AddOptions({
    super.key,
    required this.onLove,
    required this.onShare,
    required this.onQuote,
    required this.onSave,
    required this.likes,
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
        child: GestureDetector(
          onTap: () => onQuote(),
          child: SvgPicture.asset(
            quoteIcon,
            width: 25,
            colorFilter: const ColorFilter.mode(
              Color(0xFF531900),
              BlendMode.srcIn))
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10,right: 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onLove(),
              child: SvgPicture.asset(
                loveIcon,
                width: 25,
                colorFilter:  ColorFilter.mode(
                  const Color(0xFF531900).withAlpha(170),
                  BlendMode.srcIn))
            ),
            if(likes > 0) Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF531900).withAlpha(170),
                ),
              ),
            ),
          ],
        ),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.only(left: 5,right: 10),
        child: GestureDetector(
          onTap: () => onSave(),
          child: SvgPicture.asset(
            saveIcon,
            width: 25,
            colorFilter: ColorFilter.mode(
              const Color(0xFF531900).withAlpha(170),
              BlendMode.srcIn))
        ),
      ),
    ],
    ),
    );
}