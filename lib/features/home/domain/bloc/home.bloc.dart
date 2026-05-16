import 'package:alice/api/get_adds.dart';
import 'package:alice/config.dart';
import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:alice/models/adds/adds.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddsBloc extends Bloc<AddsEvent, AddsState> {
  AddsBloc() : super(const AddsState()) {
    on<LoadAdds>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Adds');
      final List<Adds> result = [];
      emit(state.copyWith(adds: state.adds, isLoadingAdds: true));
      try{
        final rawResponse = await getAddsQuery();
        for (Map<String, dynamic> add in rawResponse['adds']) {
          try{
            final adds = Adds.fromJson(add);
            result.add(adds);
          } catch(e){
            logger.error('Failed to load add, skipping...');
          }
        }
        emit(state.copyWith(adds: result, isLoadingAdds: false));
      } catch(e){
        logger.error('Failed to request adds: ${e.toString()}');
        emit(state.copyWith(isLoadingAdds: false));
      }
    });
  }
}