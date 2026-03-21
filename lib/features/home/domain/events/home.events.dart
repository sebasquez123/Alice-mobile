import 'package:equatable/equatable.dart';

abstract class AddsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadAdds extends AddsEvent {}