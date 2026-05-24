import 'package:equatable/equatable.dart';

abstract class AdsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadAds extends AdsEvent {}