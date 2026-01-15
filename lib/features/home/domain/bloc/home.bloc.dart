import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FactionBloc extends Bloc<FactionEvent, FactionState> {
  FactionBloc() : super(const FactionState('horde', 0)) {
    on<ToggleFaction>((event, emit) {
      emit(FactionState(state.faction == 'horde' ? 'aliance' : 'horde', state.count));
    });
  }
}