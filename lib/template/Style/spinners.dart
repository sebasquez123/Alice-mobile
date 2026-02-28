import 'package:alice/template/Style/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerProvider {
  static SpinKitCircle get spinnerLg => SpinKitCircle(color: ColorProvider.loadingSpinner, size: 70.0);
  static SpinKitCircle get spinnerSm => SpinKitCircle(color: ColorProvider.loadingSpinner, size: 30.0);
  static SpinKitCircle get spinnerXs => SpinKitCircle(color: ColorProvider.loadingSpinner, size: 15.0);

  static SpinKitThreeBounce get threeBounceLg => SpinKitThreeBounce(color: ColorProvider.loadingThreeBounce, size: 70.0);
  static SpinKitThreeBounce get threeBounceSm => SpinKitThreeBounce(color: ColorProvider.loadingThreeBounce, size: 30.0);
  static SpinKitThreeBounce get threeBounceXs => SpinKitThreeBounce(color: ColorProvider.loadingThreeBounce, size: 15.0);
}