import 'package:chifabrasil_admin/providers/providers.dart';
import 'package:chifabrasil_admin/routes/app_route.dart';
import 'package:chifabrasil_admin/services/push_notifications_service.dart';
import 'package:chifabrasil_admin/services/services.dart';
import 'package:chifabrasil_admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrdersService()),
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleService(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesService(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => DishesService(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => DishFormProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleFormProvider(),
          lazy: true,
        ),
        
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoute.initialRoute,
      routes: AppRoute.getAppRoutes(),
      theme: AppTheme.lightTheme,
    );
  }
}
