import 'package:alice/api/get_preferences.dart';
import 'package:alice/config.dart';
import 'package:alice/features/preferences/domain/data/preferences.state.dart';
import 'package:alice/features/preferences/domain/events/preferences.events.dart';
import 'package:alice/models/adds/adds.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddsBloc extends Bloc<SavedAddsEvent, SavedAddsState> {
  SavedAddsBloc() : super(const SavedAddsState()) {
    on<LoadSavedAdds>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Saved_Adds');
      final List<Adds> result = [];
      emit(state.copyWith(savedAdds: [], isLoadingSavedAdds: true));
      try{
        final rawResponse = await getPreferencesQuery();
        for (Map<String, dynamic> add in rawResponse['preferences']['savedAdds']) {
          try{
            final adds = Adds.fromJson(add);
            result.add(adds);
          } catch(e){
            logger.error('Failed to load saved add, skipping...');
          }
        }
        emit(state.copyWith(savedAdds: result, isLoadingSavedAdds: false));
      } catch(e){
        logger.error('Failed to request savedAdds: ${e.toString()}');
        emit(state.copyWith(isLoadingSavedAdds: false));
      }
    });
  }
}

class LikedAddsBloc extends Bloc<LikedAddsEvent, LikedAddsState> {
  LikedAddsBloc() : super(const LikedAddsState()) {
    on<LoadLikedAdds>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Liked_Adds');
      final List<Adds> result = [];
      emit(state.copyWith(likedAdds: [], isLoadingLikedAdds: true));
      try {
        final rawResponse = await getPreferencesQuery();
        final currentAdds = event.adds;
        for (String addId in rawResponse['preferences']['likedAdds']) {
          final add = currentAdds.firstWhereOrNull((add) => add.addId == addId);
          if (add != null) result.add(add);
        }
        emit(state.copyWith(likedAdds: result, isLoadingLikedAdds: false));
      } catch(e){
        logger.error('Failed to request likedAdds: ${e.toString()}');
        emit(state.copyWith(isLoadingLikedAdds: false));
      }
    });
  }
}