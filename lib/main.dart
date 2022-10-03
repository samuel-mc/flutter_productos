import 'package:flutter/material.dart';
import 'package:productos_app/helpers/custom_colors.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'product': (_) => const ProductScreen(),
        'register': (_) => const RegisterScreen()
      },
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(color: CustomColors.darkBlue),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: CustomColors.purple,
              foregroundColor: Colors.white),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: CustomColors.lightBlue)),
    );
  }
}
