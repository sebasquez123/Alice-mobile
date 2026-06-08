import 'package:alice/api/get_ads.dart';
import 'package:alice/config.dart';
import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:alice/models/ads/ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  AdsBloc() : super(const AdsState()) {
    on<LoadAds>((event, emit) async {
      final logger = LoggerConfig(instanceName: 'Bloc_Ads');
      final List<Ads> result = [];
      emit(state.copyWith(ads: state.ads, isLoadingAds: true));
      try{
        final rawResponse = await getAdsQuery();
        for (Map<String, dynamic> ad in rawResponse['ads']) {
          try{
            final ads = Ads.fromJson(ad);
            result.add(ads);
          } catch(e){
            logger.error('Failed to load ad, skipping...');
          }
        }
        logger.info('Successfully requested ads');
        emit(state.copyWith(ads: result, isLoadingAds: false, isErrorAds: false));
      } catch(e){
        logger.error('Failed to request ads: ${e.toString()}');
        emit(state.copyWith(isLoadingAds: false, isErrorAds: true));
      }
    });
  }
}