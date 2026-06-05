import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:keeply/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keeply/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:keeply/features/auth/presentation/pages/login_page.dart';
import 'package:keeply/features/auth/presentation/pages/register_page.dart';
import 'package:keeply/features/auth/presentation/pages/settings_page.dart';
import 'package:keeply/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:keeply/features/storage/presentation/pages/container_detail_page.dart';
import 'package:keeply/features/storage/presentation/pages/container_form_page.dart';
import 'package:keeply/features/storage/presentation/pages/item_detail_page.dart';
import 'package:keeply/features/storage/presentation/pages/item_form_page.dart';
import 'package:keeply/features/storage/presentation/pages/move_destination_page.dart';
import 'package:keeply/features/storage/presentation/pages/space_detail_page.dart';
import 'package:keeply/features/storage/presentation/pages/space_form_page.dart';
import 'package:keeply/features/storage/presentation/pages/spaces_list_page.dart';
import 'package:keeply/features/subscription/presentation/pages/subscription_status_page.dart';

class AppRouter {
  AppRouter(this._authBloc)
    : router = GoRouter(
        initialLocation: '/splash',
        refreshListenable: GoRouterRefreshStream(_authBloc.stream),
        redirect: (context, state) {
          final auth = _authBloc.state;
          final location = state.matchedLocation;
          final authPage = location == '/login' || location == '/register';
          if (auth is AuthUnknown)
            return location == '/splash' ? null : '/splash';
          if (auth is AuthUnauthenticated || auth is AuthFailure)
            return authPage ? null : '/login';
          if (auth is AuthAuthenticated && (authPage || location == '/splash'))
            return '/dashboard';
          return null;
        },
        routes: [
          GoRoute(
            path: '/splash',
            builder: (context, state) => const AuthGatePage(),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/spaces',
            builder: (context, state) => const SpacesListPage(),
          ),
          GoRoute(
            path: '/spaces/new',
            builder: (context, state) => const SpaceFormPage(),
          ),
          GoRoute(
            path: '/spaces/:spaceId',
            builder: (context, state) =>
                SpaceDetailPage(spaceId: state.pathParameters['spaceId']!),
          ),
          GoRoute(
            path: '/containers/new/:parentId',
            builder: (context, state) =>
                ContainerFormPage(parentId: state.pathParameters['parentId']!),
          ),
          GoRoute(
            path: '/containers/:containerId',
            builder: (context, state) => ContainerDetailPage(
              containerId: state.pathParameters['containerId']!,
            ),
          ),
          GoRoute(
            path: '/items/new',
            builder: (context, state) => const ItemFormPage(parentId: ''),
          ),
          GoRoute(
            path: '/items/new/:parentId',
            builder: (context, state) =>
                ItemFormPage(parentId: state.pathParameters['parentId']!),
          ),
          GoRoute(
            path: '/items/:itemId',
            builder: (context, state) =>
                ItemDetailPage(itemId: state.pathParameters['itemId']!),
          ),
          GoRoute(
            path: '/move/:nodeType/:nodeId',
            builder: (context, state) => MoveDestinationPage(
              nodeType: state.pathParameters['nodeType']!,
              nodeId: state.pathParameters['nodeId']!,
            ),
          ),
          GoRoute(
            path: '/subscription',
            builder: (context, state) => const SubscriptionStatusPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      );
  final AuthBloc _authBloc;
  final GoRouter router;

  AuthBloc get authBloc => _authBloc;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
