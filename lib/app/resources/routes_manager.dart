import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sodany/presentation/login/view/login_screen.dart';
import 'package:sodany/presentation/profile/view/profile_screen.dart';
import 'package:sodany/presentation/quotation/view/quotation_screen.dart';
import 'package:sodany/presentation/register/view/register_screen.dart';
import 'package:sodany/presentation/shipping/view/shipping_screen.dart';
import 'package:sodany/presentation/travelling/view/travelling_screen.dart';
import '../../presentation/add_payment_method_screen/view/add_payment_method_screen.dart';
import '../../presentation/history/view/history_screen.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/otp_verification/view/otp_verification_screen.dart';
import '../../presentation/payment_method/view/payment_method_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../../presentation/success_otp_verification/view/success_otp_verification_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String homeRoute = "/homeRoute";
  static const String selectTripRoute = "/selectTripRoute";
  static const String travellingRoute = "/travellingRoute";
  static const String shippingRoute = "/shippingRoute";
  static const String otpVerificationRoute = "/otpVerificationRoute";
  static const String successOtpVerificationRoute =
      "/successOtpVerificationRoute";
  static const String addPaymentMethodRoute = "/addPaymentMethodRoute";
  static const String paymentMethodRoute = "/paymentMethodRoute";
  static const String quotationRoute = "/quotationRoute";
  static const String profileRoute = "/profileRoute";
  static const String historyRoute = "/historyRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case Routes.travellingRoute:
        return MaterialPageRoute(
          builder: (_) => const TravellingScreen(),
        );

      case Routes.shippingRoute:
        return MaterialPageRoute(
          builder: (_) => ShippingScreen(),
        );

      case Routes.paymentMethodRoute:
        return MaterialPageRoute(
          builder: (_) => PaymentMethodScreen(),
        );
      case Routes.addPaymentMethodRoute:
        return MaterialPageRoute(
          builder: (_) => const AddPaymentMethodScreen(),
        );
      case Routes.otpVerificationRoute:
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(),
        );
      case Routes.successOtpVerificationRoute:
        return MaterialPageRoute(
          builder: (_) => SuccessOtpVerificationScreen(),
        );
      case Routes.quotationRoute:
        return MaterialPageRoute(
          builder: (_) => const QuotationScreen(),
        );

      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case Routes.historyRoute:
        return MaterialPageRoute(
          builder: (_) => const HistoryLayout(),
        );
      default:
        return unDefiendRoute();
    }
  }

  static Route<dynamic> unDefiendRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.notFound.tr()),
        ),
        body: Center(
          child: Text(
            AppStrings.notFound.tr(),
          ),
        ),
      ),
    );
  }
}
