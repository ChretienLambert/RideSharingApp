import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/ride_provider.dart';
import 'core/services/navigation_service.dart';
import 'core/utils/app_logger.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/role_selection_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/phone_auth_screen.dart';
import 'presentation/screens/passenger_home_screen.dart';
import 'presentation/screens/driver_dashboard_screen.dart';
import 'presentation/screens/admin_dashboard_screen.dart';
import 'presentation/screens/ride_booking_screen.dart';
import 'presentation/screens/payment_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/scheduled_routes_screen.dart';
import 'presentation/screens/ride_history_screen.dart';
import 'presentation/screens/notifications_screen.dart';
import 'presentation/screens/create_ride_screen.dart';
import 'presentation/screens/my_rides_screen.dart';
import 'presentation/screens/ride_requests_screen.dart';
import 'presentation/screens/user_management_screen.dart';
import 'presentation/screens/complaint_management_screen.dart';
import 'presentation/screens/pricing_control_screen.dart';
import 'presentation/screens/search_results_screen.dart';
import 'presentation/screens/ride_detail_screen.dart';
import 'presentation/screens/driver_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize logger to capture all error levels
  AppLogger.initialize(
    enableConsoleLogs: true,
    minLogLevel: LogLevel.debug,
  );

  // Catch Flutter errors
  FlutterError.onError = (errorDetails) {
    AppLogger.fatal(
      'Flutter framework error',
      tag: 'FlutterError',
      error: errorDetails.exception,
      stackTrace: errorDetails.stack,
    );
    FlutterError.presentError(errorDetails);
  };

  // Catch async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.fatal(
      'Platform error',
      tag: 'PlatformError',
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  runApp(const RideSharingApp());
}

class RideSharingApp extends StatelessWidget {
  const RideSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RideProvider()),
      ],
      child: MaterialApp(
        title: 'Co-Voiturage Cameroun',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', 'FR'),
          Locale('en', 'US'),
        ],
        locale: const Locale('fr', 'FR'),
        home: const SplashScreen(),
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: (settings) {
          AppLogger.logNavigation('unknown', settings.name ?? 'unknown',
              arguments: settings.arguments as Map<String, dynamic>?);
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case '/role-selection':
              return MaterialPageRoute(
                  builder: (_) => const RoleSelectionScreen());
            case '/onboarding':
              return MaterialPageRoute(
                  builder: (_) => const OnboardingScreen());
            case '/phone-auth':
              return MaterialPageRoute(builder: (_) => const PhoneAuthScreen());
            case '/passenger-home':
              return MaterialPageRoute(
                  builder: (_) => const PassengerHomeScreen());
            case '/driver-dashboard':
              return MaterialPageRoute(
                  builder: (_) => const DriverDashboardScreen());
            case '/admin-dashboard':
              return MaterialPageRoute(
                  builder: (_) => const AdminDashboardScreen());
            case '/ride-booking':
              return MaterialPageRoute(
                  builder: (_) => const RideBookingScreen());
            case '/payment':
              return MaterialPageRoute(builder: (_) => const PaymentScreen());
            case '/profile':
              return MaterialPageRoute(builder: (_) => const ProfileScreen());
            case '/scheduled-routes':
              return MaterialPageRoute(
                  builder: (_) => const ScheduledRoutesScreen());
            case '/ride-history':
              return MaterialPageRoute(
                  builder: (_) => const RideHistoryScreen());
            case '/notifications':
              return MaterialPageRoute(
                  builder: (_) => const NotificationsScreen());
            case '/create-ride':
              return MaterialPageRoute(
                  builder: (_) => const CreateRideScreen());
            case '/my-rides':
              return MaterialPageRoute(builder: (_) => const MyRidesScreen());
            case '/requests':
              return MaterialPageRoute(
                  builder: (_) => const RideRequestsScreen());
            case '/user-management':
              return MaterialPageRoute(
                  builder: (_) => const UserManagementScreen());
            case '/complaints':
              return MaterialPageRoute(
                  builder: (_) => const ComplaintManagementScreen());
            case '/complaint-management':
              return MaterialPageRoute(
                  builder: (_) => const ComplaintManagementScreen());
            case '/pricing-control':
              return MaterialPageRoute(
                  builder: (_) => const PricingControlScreen());
            case '/search-results':
              return MaterialPageRoute(
                  builder: (_) => SearchResultsScreen(
                        searchParams:
                            settings.arguments as Map<String, dynamic>?,
                      ));
            case '/ride-detail':
              return MaterialPageRoute(
                  builder: (_) => const RideDetailScreen(), settings: settings);
            case '/driver-profile':
              return MaterialPageRoute(
                  builder: (_) => const DriverProfileScreen(),
                  settings: settings);
            default:
              AppLogger.warning('Unknown route: ${settings.name}',
                  tag: 'Navigation');
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Route inconnue: ${settings.name}'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
