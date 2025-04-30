import 'package:contatos/ui/add/add_screen.dart';
import 'package:contatos/ui/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        final id = state.uri.queryParameters['edit'];
        return AddScreen(contactId: id);
      },
    ),
  ],
);
