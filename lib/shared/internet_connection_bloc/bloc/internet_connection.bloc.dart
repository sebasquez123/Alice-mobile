

class InternetCheckerBloc extends Bloc<InternetCheckerEvent, InternetCheckerState> {
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
        emit(state.copyWith(isLoadingMostrario: false, mostrarios: result));
      } catch(e){
        logger.error('Failed to request Mostrarios: ${e.toString()}');
        emit(state.copyWith(isLoadingMostrario: false, mostrarios: const []));
      }
    });
  }
}