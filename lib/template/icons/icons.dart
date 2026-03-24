import 'package:alice/config.dart';
import 'package:cached_network_image/cached_network_image.dart';

final logger = LoggerConfig(instanceName: 'Icons').logger;

final baseIconsPath = 'assets/icons/';
final baseLogosPath = 'assets/bussines/';

final String googleIcon = '${baseIconsPath}google-icon.svg';
final String appleIcon = '${baseIconsPath}apple-icon.svg';
final String locationIcon = '${baseIconsPath}location-icon.svg';
final String balloonIcon = '${baseIconsPath}chat-balloon.svg';
final String speakerIcon = '${baseIconsPath}speaker-icon.svg';
final String arrowBackIcon = '${baseIconsPath}arrow-back-archive-icon.svg';
final String gearIcon = '${baseIconsPath}gear-icon.svg';
final String trashIcon = '${baseIconsPath}trash-icon.svg';
final String editIcon = '${baseIconsPath}edit-icon.svg';
final String barsIcon = '${baseIconsPath}bars-icon.svg';
final String bookIcon = '${baseIconsPath}address-icon.svg';
final String archiveIcon = '${baseIconsPath}archive-icon.svg';
final String emailIcon = '${baseIconsPath}email-icon.svg';
final String globeIcon = '${baseIconsPath}globe-icon.svg';
final String infoIcon = '${baseIconsPath}info-icon.svg';
final String helpIcon = '${baseIconsPath}question-icon.svg';
final String lockIcon = '${baseIconsPath}privacy-icon.svg';
final String signOutIcon = '${baseIconsPath}sign-out-icon.svg';
final String copyTextIcon = '${baseIconsPath}copy-text-icon.svg';
final String shareIcon = '${baseIconsPath}share-icon.svg';
final String messageIcon = '${baseIconsPath}newchat-icon.svg';
final String sendIcon = '${baseIconsPath}send-icon.svg';
final String copyMessageIcon = '${baseIconsPath}copy-message-icon.svg';
final String thumbDownIcon = '${baseIconsPath}thumb-down-icon.svg';
final String thumbUpIcon = '${baseIconsPath}thumb-up-icon.svg';
final String flaskIcon = '${baseIconsPath}experiment-icon.svg';
final String urlIcon = '${baseIconsPath}url-icon.svg';
final String unarchiveIcon = '${baseIconsPath}unarchive-icon.svg';
final String loveIcon = '${baseIconsPath}love-icon.svg';
final String saveIcon = '${baseIconsPath}save-icon.svg';
final String quoteIcon = '${baseIconsPath}quote-icon.svg';

// local logos
final String logoMain = '${baseLogosPath}main.png';
final String logoWatermark = '${baseLogosPath}watermark.png';
final String logoTopbar = '${baseLogosPath}topbar.png';

// remote logos
final String gMain = 'W1cV4t4S/main.png';
final String gWatermark = 'DzrfdLSg/watermark.png';
final String gTopbar = 'zfCDSKyC/topbar.png';

String getNetworkLogo(String bucketLogo) => 'https://i.postimg.cc/$bucketLogo';

Future<void> disposeLogoCache() async {
  final List<String> names = [
    gMain,
    gWatermark,
    gTopbar,
  ];
  for (var name in names) {
    final url = getNetworkLogo(name);
    await CachedNetworkImage.evictFromCache(url);
  }
}
