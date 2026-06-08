import 'package:alice/firebase/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';


void config() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    final DotEnv env = DotEnv();
    final DotEnv envExample = DotEnv();

    await env.load(fileName: '.env');
    await envExample.load(fileName: '.env.example');

    final envKeys = env.env.keys.toList();
    final envExpKeys = envExample.env.keys.toList();

    final missedEnvironmentVariables = envExpKeys.where(
      (key) => !envKeys.contains(key),
    ).toList();

    if (missedEnvironmentVariables.isNotEmpty) {
      throw Exception(
        'Missing environment variables: $missedEnvironmentVariables',
      );
    }
    await dotenv.load(fileName: '.env');
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );
    }

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, 
      systemNavigationBarColor: Colors.black,
    ));

  } catch (e) {
    throw Exception('Error Initializing the app: $e');
  }
}

class LoggerConfig {
  final String instanceName;
  late Logger logger;
  LoggerConfig({ required this.instanceName }){

    final config = PrettyPrinter(
        methodCount: 0,
        colors: true,
        printEmojis: false,
        lineLength: 90
    );
    logger = Logger(printer: config);
  }

  void warning(String message) => logger.w('[$instanceName] Warning: $message');
  void info(String message) => logger.i('[$instanceName] Info: $message');
  void error(String message) => logger.e('[$instanceName] Error: $message');
  void critical(String message) => logger.f('[$instanceName] Critical: $message');
  void debug(String message) => logger.d('[$instanceName] Debug: $message');
}

class AppConfig {
  String get firebaseProjectId => dotenv.get('FIREBASE_PROJECT_ID');
  String get firebaseStorageBucket => dotenv.get('FIREBASE_STORAGE_BUCKET');
  String get firebaseMessagingSenderId =>
      dotenv.get('FIREBASE_MESSAGING_SENDER_ID');
  String get firebaseAndroidClientId =>
      dotenv.get('FIREBASE_ANDROID_CLIENT_ID');
  String get firebaseAndroidApiKey => dotenv.get('FIREBASE_ANDROID_API_KEY');
  String get firebaseAndroidAppId => dotenv.get('FIREBASE_ANDROID_APP_ID');
  String get firebaseIosClientId => dotenv.get('FIREBASE_IOS_CLIENT_ID');
  String get firebaseIosApiKey => dotenv.get('FIREBASE_IOS_API_KEY');
  String get firebaseIosAppId => dotenv.get('FIREBASE_IOS_APP_ID');
  String get firebaseIosBundleId => dotenv.get('FIREBASE_IOS_BUNDLE_ID');
}
