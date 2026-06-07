import 'package:alice/models/ads/ads.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';

class AddImagePost extends StatelessWidget {
  final Ads add;

  const AddImagePost({
    super.key,
    required this.add,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: add.images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, imgIdx) => Stack(
          children: [
            Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorProvider.denary.withValues(alpha: 0.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  add.images[imgIdx],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress){
                    if (loadingProgress == null) return child;
                    return Center(child: SpinnerProvider.spinnerSm);
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                    ),
                  ),
                ),
              ),
            ),
            if(imgIdx == 0)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF531900),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    add.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}