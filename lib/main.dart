import 'package:design/bloc/authbloc.dart';
import 'package:design/chatbot/chatbot_bloc.dart';
import 'package:design/domain/loginusecase.dart';
import 'package:design/domain/signupusecase.dart';
import 'package:design/repositery/data.dart';
import 'package:design/screens/chatbox.dart';
import 'package:design/screens/login.dart';
import 'package:design/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) => const ChatbotScreen(),
      ),
    ],
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (isLoggedIn && state.uri.toString() == '/login') {
        return '/chatbot';
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            LoginUseCase(AuthRepository()),
            SignupUseCase(AuthRepository()),
          ),
        ),
        BlocProvider(
          create: (context) => ChatbotBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Chatbot App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        routerConfig: _router,
      ),

    );
  }
}