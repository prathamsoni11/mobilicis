import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobilicis/providers/home_page_providers.dart';
import 'package:mobilicis/screens/home_page_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyImageCache extends ImageCache {
  @override
  void clear() {
    print('Clearing cache!');
    // Clears all images from the cache
    // PaintingBinding.instance.imageCache.clear();

    // Clears live images from the cache
    PaintingBinding.instance.imageCache.clearLiveImages();
    super.clear();
  }
}

class MyWidgetsBinding extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() => MyImageCache();
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

void main() async {
  MyWidgetsBinding();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => HomePageProviders(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff2C2E43),
          ),
        ),
        home: const HomePageScreen(),
      ),
    );
  }
}
