import 'package:dtradmin/view/home_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';

import 'provider/branch_employee_provider.dart';
import 'provider/branch_provider.dart';
import 'provider/department_employee_provider.dart';
import 'provider/departmet_provider.dart';
import 'provider/device_log_provider.dart';
import 'provider/device_provider.dart';
import 'provider/employee_provider.dart';
// import 'view/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceProvider>(
          create: (_) => DeviceProvider(),
        ),
        ChangeNotifierProvider<DeviceLogProvider>(
          create: (_) => DeviceLogProvider(),
        ),
        ChangeNotifierProvider<BranchProvider>(
          create: (_) => BranchProvider(),
        ),
        ChangeNotifierProvider<BranchEmployeeProvider>(
          create: (_) => BranchEmployeeProvider(),
        ),
        ChangeNotifierProvider<DepartmentProvider>(
          create: (_) => DepartmentProvider(),
        ),
        ChangeNotifierProvider<DepartmentEmployeeProvider>(
          create: (_) => DepartmentEmployeeProvider(),
        ),
        ChangeNotifierProvider<EmployeeProvider>(
          create: (_) => EmployeeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'UC-1 DTR Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      // home: const LoginView(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
