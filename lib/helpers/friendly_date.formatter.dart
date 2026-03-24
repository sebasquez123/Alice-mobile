import 'package:intl/intl.dart';

String friendlyDateFormatter(DateTime createdAt) {
  final now = DateTime.now();
  final diff = now.difference(createdAt);
  final hourStr = DateFormat('HH:mm').format(createdAt);

  if (diff.inMinutes < 60) {
    return 'Hace ${diff.inMinutes} minutos';
  } else if (diff.inHours < 24) {
    return 'Hace ${diff.inHours} horas';
  } else if (diff.inDays < 7) {
    return 'Hace ${diff.inDays} dias';
  } else if (diff.inDays < 30) {
    final weeks = (diff.inDays / 7).floor();
    return 'Hace $weeks semanas';
  } else {
    final dateStr = DateFormat('dd MMMM yyyy').format(createdAt);
    return 'Hace $dateStr - $hourStr';
  }
}
