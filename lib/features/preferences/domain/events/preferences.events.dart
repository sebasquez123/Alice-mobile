import 'package:alice/models/adds/adds.dart';
import 'package:equatable/equatable.dart';

abstract class LikedAddsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadLikedAdds extends LikedAddsEvent {
  final List<Adds> adds;
  LoadLikedAdds({this.adds = const []});
}


abstract class SavedAddsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadSavedAdds extends SavedAddsEvent {}