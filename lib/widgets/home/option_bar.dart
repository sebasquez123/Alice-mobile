import 'package:alice/models/ads/ads.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddOptions extends StatelessWidget {
  final Ads add;
  final Function onShare;
  final Function onQuote;
  final Function onMenu;

  const AddOptions({
    super.key,
    required this.add,
    required this.onShare,
    required this.onQuote,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: GestureDetector(
                onTap: () => onShare(),
                child: SvgPicture.asset(
                  shareIcon,
                  width: 25,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF531900),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            if(add.standardProductId != null)
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: GestureDetector(
                  onTap: () => onQuote(),
                  child: SvgPicture.asset(
                  billIcon,
                  width: 26,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF531900),
                    BlendMode.srcIn,
                  ),
                ),
                ),
              ),
          ],
        ),
        GestureDetector(
          onTap: () => onMenu(),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.more_vert,
              color: const Color(0xFF531900).withAlpha(200),
              size: 26,
            ),
          ),
        ),
      ],
    ),
  );
}