import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeply/core/di/service_locator.dart';
import 'package:keeply/core/routing/app_router.dart';
import 'package:keeply/core/theme/app_theme.dart';
import 'package:keeply/features/auth/presentation/bloc/auth_bloc.dart';

class KeeplyApp extends StatefulWidget {
  const KeeplyApp({super.key});

  @override
  State<KeeplyApp> createState() => _KeeplyAppState();
}

class _KeeplyAppState extends State<KeeplyApp> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>();
    _appRouter = AppRouter(_authBloc);
    _authBloc.add(const AuthStarted());
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: MaterialApp.router(
        title: 'Keeply',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: _appRouter.router,
      ),
    );
  }
}
