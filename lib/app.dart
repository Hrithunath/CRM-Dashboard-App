import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:pulse/features/auth/views/screens/login_screen.dart';
import 'core/theme/app_theme.dart';
import 'package:pulse/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:pulse/features/dashboard/controllers/dashboard_controller.dart';
import 'package:pulse/features/companies/controllers/companies_controller.dart';
import 'package:pulse/features/dashboard/services/dashboard_repository.dart';
import 'package:pulse/features/companies/services/company_repository.dart';

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        ProxyProvider<Dio, DashboardRepository>(
          update: (_, dio, __) => DashboardRepository(dio),
        ),
        ProxyProvider<Dio, CompanyRepository>(
          update: (_, dio, __) => CompanyRepository(dio),
        ),
        ChangeNotifierProvider<DashboardController>(
          create: (context) => DashboardController(context.read<DashboardRepository>()),
        ),
        ChangeNotifierProvider<CompaniesController>(
          create: (context) => CompaniesController(context.read<CompanyRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Pulse CRM',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasData) {
              return const DashboardScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
