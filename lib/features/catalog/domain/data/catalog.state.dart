import 'package:alice/models/catalog/mostrarios.dart';
import 'package:alice/models/catalog/products.dart';
import 'package:equatable/equatable.dart';


class CatalogMostrarioState extends Equatable {
  final bool isLoadingMostrario;
  final bool isErrorMostrario;
  final List<Mostrarios> mostrarios;

  const CatalogMostrarioState({
    this.isLoadingMostrario = false,
    this.isErrorMostrario = false,
    this.mostrarios = const [],
  });

  CatalogMostrarioState copyWith({
    bool? isLoadingMostrario,
    bool? isErrorMostrario,
    List<Mostrarios>? mostrarios,
  }) => CatalogMostrarioState(
      isLoadingMostrario: isLoadingMostrario ?? this.isLoadingMostrario,
      mostrarios: mostrarios ?? this.mostrarios,
      isErrorMostrario: isErrorMostrario ?? this.isErrorMostrario,
    );

  @override
  List<Object?> get props => [isLoadingMostrario, mostrarios, isErrorMostrario];
}


class CatalogProductState extends Equatable {
  final bool isLoadingProducts;
  final List<Products> products;
  final bool isErrorProducts;
  const CatalogProductState({
    this.isLoadingProducts = false,
    this.products = const [],
    this.isErrorProducts = false,
  });

  CatalogProductState copyWith({
    bool? isLoadingProducts,
    List<Products>? products,
    bool? isErrorProducts,
  }) => CatalogProductState(
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      products: products ?? this.products,
      isErrorProducts: isErrorProducts ?? this.isErrorProducts,
    );

  @override
  List<Object?> get props => [isLoadingProducts, products, isErrorProducts];
}