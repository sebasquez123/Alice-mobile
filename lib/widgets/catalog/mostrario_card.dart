import 'package:alice/helpers/index.dart';
import 'package:alice/models/catalog/mostrarios.dart';
import 'package:flutter/material.dart';

class MostrarioCard extends StatelessWidget {
  final Mostrarios mostrario;

  const MostrarioCard({
    super.key,
    required this.mostrario,
  });

  @override
  Widget build(BuildContext context) => Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF531900),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  mostrario.category.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
            child: Image.network(
              mostrario.images.first,
              fit: BoxFit.cover,
              height: 180,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              truncateText(mostrario.title, 20),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF2C2C2C),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
}
