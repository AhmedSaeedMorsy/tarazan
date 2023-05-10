import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/constants_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  void _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: AppConstants.splashTime,
      ),
      _nextScreen,
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ZoomIn(
          duration: const Duration(
            seconds: AppIntDuration.duration2,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s10,
            ),
            child: const Image(
              image: AssetImage(
                AssetsManager.logo,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _nextScreen() {
    if (CacheHelper.getData(key: SharedKey.token) != null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.homeRoute,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.loginRoute,
      );
    }
  }
}
