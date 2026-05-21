import 'package:alice/widgets/catalog/mostrario_card.dart';
import 'package:alice/widgets/catalog/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<Widget> buildGroupedProductList({
  required Map<String, dynamic> groupedProducts,
}) => [
  ...groupedProducts.entries.map((entry) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF531900),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Center(
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            ...entry.value.map((item) => ProductCard(product: item)),
          ]
        ),
      ),
    ],
  ))
];

List<Widget> buildGroupedMostrariosList({
  required Map<String, dynamic> groupedMostrarios,
}) => [
  ...groupedMostrarios.entries.map((entry) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Divider(),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            ...entry.value.map((item) => MostrarioCard(mostrario: item)),
          ]
        ),
      ),
    ],
  )),
];