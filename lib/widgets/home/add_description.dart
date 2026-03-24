import 'package:flutter/material.dart';

class AddDescription extends StatelessWidget {
  final String description;
  final String title;
  final List<String> tags;

  const AddDescription({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 5, right: 20, top: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            TextSpan(text: ' $description', style: const TextStyle(color: Colors.black)),
            ...tags.map((tag) => TextSpan(
              text: ' $tag',
              style: const TextStyle(color: Color.fromARGB(255, 255, 0, 179)),
            )),
          ],
        ),
      ),
    );
}