import 'package:alice/api/get_mostrario.dart';
import 'package:alice/api/get_products.dart';
import 'package:alice/config.dart';
import 'package:alice/features/catalog/domain/data/catalog.state.dart';
import 'package:alice/features/catalog/domain/events/catalog.events.dart';
import 'package:alice/models/catalog/mostrarios.dart';
import 'package:alice/models/catalog/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogMostrarioBloc extends Bloc<CatalogMostrarioEvent, CatalogMostrarioState> {
  CatalogMostrarioBloc() : super(const CatalogMostrarioState()) {
    on<LoadCatalogMostrario>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Catalog_Mostrario');
      final List<Mostrarios> result = [];
      emit(state.copyWith(isLoadingMostrario: true, mostrarios: const []));
      try {
        final rawResponse = await getMostrarioQuery();
        for (Map<String, dynamic> element in rawResponse['mostrario']) {
          try{
            final samples = Mostrarios.fromJson(element);
            result.add(samples);
          } catch(e){
            logger.error('Failed to load mostrario, skipping...');
          }
        }
        emit(state.copyWith(isLoadingMostrario: false, mostrarios: result, isErrorMostrario: false));
      } catch(e){
        logger.error('Failed to request Mostrarios: ${e.toString()}');
        emit(state.copyWith(isLoadingMostrario: false, mostrarios: const [], isErrorMostrario: true));
      }
    });
  }
}

class CatalogProductBloc extends Bloc<CatalogProductEvent, CatalogProductState> {
  CatalogProductBloc() : super(const CatalogProductState()) {
    on<LoadCatalogProduct>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Catalog_Product');
      final List<Products> result = [];
      emit(state.copyWith(isLoadingProducts: true, products: const []));
      try {
        final rawResponse = await getProductsQuery();
        for (Map<String, dynamic> element in rawResponse['products']) {
          try{
            final product = Products.fromJson(element);
            result.add(product);
          } catch(e){
            logger.error('Failed to load product, skipping...');
          }
        }
        emit(state.copyWith(isLoadingProducts: false, products: result, isErrorProducts: false));
      } catch(e){
        logger.error('Failed to request products: ${e.toString()}');
        emit(state.copyWith(isLoadingProducts: false, products: const [], isErrorProducts: true));
      }
    });
  }
}