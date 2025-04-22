import 'package:contatos/pages/add.dart';
import 'package:contatos/pages/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        final id = state.uri.queryParameters['edit'];
        return AddPage(contactId: id);
      },
    ),
  ],
);
