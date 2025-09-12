import 'package:go_router/go_router.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
import 'package:todo_app_riverpod/logger/logger.dart';
import 'package:todo_app_riverpod/screen/home/add_edit_screen.dart';
import 'package:todo_app_riverpod/screen/home/home_screen.dart';
import 'package:todo_app_riverpod/screen/splash/splash_screen.dart';
// GoRouter configuration

class RouteManager {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/addEdit', builder: (context, state) {
        dp('state.extra ${state.extra.runtimeType} ${state.extra}');
        return AddEditTodoScreen(todo: state.extra as TodoData,);
      }),
    ],
  );
}
