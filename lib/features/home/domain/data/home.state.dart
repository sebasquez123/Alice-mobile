import 'package:alice/models/ads/ads.dart';
import 'package:equatable/equatable.dart';

class AdsState extends Equatable {
  final List<Ads> ads;
  final bool isLoadingAds ;
  final bool isErrorAds;

  const AdsState({
    this.ads = const [],
    this.isLoadingAds = false,
    this.isErrorAds = false,
  });

  AdsState copyWith({
    List<Ads>? ads,
    bool? isLoadingAds,
    bool? isErrorAds,
  }) => AdsState(
      ads: ads ?? this.ads,
      isLoadingAds: isLoadingAds ?? this.isLoadingAds,
      isErrorAds: isErrorAds ?? this.isErrorAds,
    );

  @override
  List<Object?> get props => [ads, isLoadingAds, isErrorAds];
}