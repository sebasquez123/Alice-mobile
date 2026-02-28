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

// local logos
final String logoArchive = '${baseLogosPath}logo_archive.png';

// remote logos
final String gcsMain = 'main_light.png';
final String gcsFooter = 'footer_light.png';
final String gcsMark = 'mark_light.png';
final String gcsBg = 'bg_light.png';

String getNetworkLogo({required String bucketLogo}) => 'AquiLaUrlDelProveedorDeArchivosStaticos%2F$bucketLogo?alt=media';

Future<void> disposeLogoCache() async {
  final List<String> names = [
    gcsMain,
    gcsFooter,
    gcsMark,
    gcsBg,
  ];
  for (var name in names) {
    final url = getNetworkLogo(bucketLogo: name);
    await CachedNetworkImage.evictFromCache(url);
  }
}
