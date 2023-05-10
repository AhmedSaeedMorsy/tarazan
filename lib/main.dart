import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/my_app.dart';
import 'app/resources/language_manager.dart';
import 'app/services/dio_helper/dio_helper.dart';
import 'app/services/shared_prefrences/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((event) {});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DioHelper.init();
  await CacheHelper.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        ARABIC_LOCAL,
        ENGLISH_LOCAL,
      ],
      path: asstesLocalePath,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
