import 'package:alice/models/ads/ads.dart';
import 'package:equatable/equatable.dart';

class AdsState extends Equatable {
  final List<Ads> ads;
  final bool isLoadingAds ;

  const AdsState({
    this.ads = const [],
    this.isLoadingAds = false,
  });

  AdsState copyWith({
    List<Ads>? ads,
    bool? isLoadingAds,
  }) => AdsState(
      ads: ads ?? this.ads,
      isLoadingAds: isLoadingAds ?? this.isLoadingAds,
    );

  @override
  List<Object?> get props => [ads, isLoadingAds];
}