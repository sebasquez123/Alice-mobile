import 'package:equatable/equatable.dart';

abstract class CatalogMostrarioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadCatalogMostrario extends CatalogMostrarioEvent {}


abstract class CatalogProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadCatalogProduct extends CatalogProductEvent {}
