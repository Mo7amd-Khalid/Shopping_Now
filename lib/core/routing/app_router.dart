import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:route_e_commerce_v2/core/routing/routes.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/view/reset_password_view.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/view/send_email_view.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/view/successful_view.dart';
import 'package:route_e_commerce_v2/features/auth/presentation/forget_password/view/verification_view.dart';
import 'package:route_e_commerce_v2/features/navigation_layout/navigation_view.dart';

import '../../features/auth/presentation/login/view/login_view.dart';
import '../../features/auth/presentation/register/register_view.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.navigationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NavigationView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterView(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Login(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SendEmailView(),
        );
      case Routes.verificationRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const VerificationView(),
        );
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ResetPasswordView(),
        );
      case Routes.successfulResetPasswordRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SuccessfulResetPasswordView(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}
