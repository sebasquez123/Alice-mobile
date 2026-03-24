import 'package:alice/helpers/friendly_date.formatter.dart';
import 'package:alice/models/adds/adds.dart';
import 'package:flutter/material.dart';

class AddHeadline extends StatelessWidget {
  final Adds add;

  const AddHeadline({
    super.key,
    required this.add,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 8, left: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              add.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF531900),
              ),
            ),
          Text(
              friendlyDateFormatter(add.createdAt),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color.fromARGB(255, 83, 25, 0).withAlpha(150),
              ),
            ),
        ],
      ),
  );
}