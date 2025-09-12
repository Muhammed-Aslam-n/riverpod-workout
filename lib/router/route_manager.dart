import 'package:go_router/go_router.dart';
import 'package:todo_app_riverpod/screen/home.dart';
import 'package:todo_app_riverpod/screen/splash/splash_screen.dart';
// GoRouter configuration

class RouteManager {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
  );
}
