import 'package:alice/models/adds/adds.dart';
import 'package:equatable/equatable.dart';

class LikedAddsState extends Equatable {
  final List<Adds> likedAdds;
  final bool isLoadingLikedAdds;

  const LikedAddsState({
    this.likedAdds = const [],
    this.isLoadingLikedAdds = false,
  });

  LikedAddsState copyWith({
    List<Adds>? likedAdds,
    bool? isLoadingLikedAdds,
  }) => LikedAddsState(
      likedAdds: likedAdds ?? this.likedAdds,
      isLoadingLikedAdds: isLoadingLikedAdds ?? this.isLoadingLikedAdds,
    );

  @override
  List<Object?> get props => [likedAdds, isLoadingLikedAdds];
}


class SavedAddsState extends Equatable {
  final List<Adds> savedAdds;
  final bool isLoadingSavedAdds;

  const SavedAddsState({
    this.savedAdds = const [],
    this.isLoadingSavedAdds = false,
  });

  SavedAddsState copyWith({
    List<Adds>? savedAdds,
    bool? isLoadingSavedAdds,
  }) => SavedAddsState(
      savedAdds: savedAdds ?? this.savedAdds,
      isLoadingSavedAdds: isLoadingSavedAdds ?? this.isLoadingSavedAdds,
    );

  @override
  List<Object?> get props => [savedAdds, isLoadingSavedAdds];
}