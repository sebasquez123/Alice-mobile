import 'package:alice/models/catalog/mostrarios.dart';
import 'package:alice/models/catalog/products.dart';
import 'package:equatable/equatable.dart';


class CatalogMostrarioState extends Equatable {
  final bool isLoadingMostrario;
  final List<Mostrarios> mostrarios;

  const CatalogMostrarioState({
    this.isLoadingMostrario = false,
    this.mostrarios = const [],
  });

  CatalogMostrarioState copyWith({
    bool? isLoadingMostrario,
    List<Mostrarios>? mostrarios,
  }) => CatalogMostrarioState(
      isLoadingMostrario: isLoadingMostrario ?? this.isLoadingMostrario,
      mostrarios: mostrarios ?? this.mostrarios,
    );

  @override
  List<Object?> get props => [isLoadingMostrario, mostrarios];
}


class CatalogProductState extends Equatable {
  final bool isLoadingProducts;
  final List<Products> products;

  const CatalogProductState({
    this.isLoadingProducts = false,
    this.products = const [],
  });

  CatalogProductState copyWith({
    bool? isLoadingProducts,
    List<Products>? products,
  }) => CatalogProductState(
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      products: products ?? this.products,
    );

  @override
  List<Object?> get props => [isLoadingProducts, products];
}