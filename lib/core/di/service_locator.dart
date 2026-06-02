import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:keeply/core/config/app_config.dart';
import 'package:keeply/core/network/api_client.dart';
import 'package:keeply/core/network/auth_interceptor.dart';
import 'package:keeply/core/network/token_refresh_interceptor.dart';
import 'package:keeply/core/storage/token_storage.dart';
import 'package:keeply/features/auth/data/auth_api.dart';
import 'package:keeply/features/auth/data/auth_repository_impl.dart';
import 'package:keeply/features/auth/domain/auth_repository.dart';
import 'package:keeply/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:keeply/features/auth/presentation/bloc/login_cubit.dart';
import 'package:keeply/features/auth/presentation/bloc/register_cubit.dart';
import 'package:keeply/features/storage/data/storage_api.dart';
import 'package:keeply/features/storage/data/storage_repository_impl.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/container_detail_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/delete_node_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/item_breadcrumb_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/item_detail_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/move_destination_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/space_tree_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/spaces_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/storage_form_cubit.dart';
import 'package:keeply/features/subscription/data/subscription_api.dart';
import 'package:keeply/features/subscription/data/subscription_repository_impl.dart';
import 'package:keeply/features/subscription/domain/subscription_repository.dart';
import 'package:keeply/features/subscription/presentation/bloc/subscription_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (sl.isRegistered<AppConfig>()) return;
  final config = AppConfig.fromEnvironment();
  final tokenStorage = SecureTokenStorage(const FlutterSecureStorage());
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  final refreshDio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokenStorage));
  dio.interceptors.add(
    TokenRefreshInterceptor(
      refreshDio: refreshDio,
      tokenStorage: tokenStorage,
      onSessionExpired: () {},
    ),
  );

  sl
    ..registerSingleton<AppConfig>(config)
    ..registerSingleton<TokenStorage>(tokenStorage)
    ..registerSingleton<Dio>(dio)
    ..registerSingleton<ApiClient>(ApiClient(dio))
    ..registerLazySingleton<AuthApi>(() => AuthApi(sl<ApiClient>()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        api: sl<AuthApi>(),
        tokenStorage: sl<TokenStorage>(),
      ),
    )
    ..registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()))
    ..registerFactory<LoginCubit>(() => LoginCubit(sl<AuthRepository>()))
    ..registerFactory<RegisterCubit>(() => RegisterCubit(sl<AuthRepository>()))
    ..registerLazySingleton<StorageApi>(() => StorageApi(sl<ApiClient>()))
    ..registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(sl<StorageApi>()),
    )
    ..registerFactory<SpacesCubit>(() => SpacesCubit(sl<StorageRepository>()))
    ..registerFactory<SpaceTreeCubit>(
      () => SpaceTreeCubit(sl<StorageRepository>()),
    )
    ..registerFactory<ContainerDetailCubit>(
      () => ContainerDetailCubit(sl<StorageRepository>()),
    )
    ..registerFactory<ItemDetailCubit>(
      () => ItemDetailCubit(sl<StorageRepository>()),
    )
    ..registerFactory<ItemBreadcrumbCubit>(
      () => ItemBreadcrumbCubit(sl<StorageRepository>()),
    )
    ..registerFactory<MoveDestinationCubit>(
      () => MoveDestinationCubit(sl<StorageRepository>()),
    )
    ..registerFactory<DeleteNodeCubit>(
      () => DeleteNodeCubit(sl<StorageRepository>()),
    )
    ..registerFactory<StorageFormCubit>(
      () => StorageFormCubit(sl<StorageRepository>()),
    )
    ..registerLazySingleton<SubscriptionApi>(
      () => SubscriptionApi(sl<ApiClient>()),
    )
    ..registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(sl<SubscriptionApi>()),
    )
    ..registerFactory<SubscriptionCubit>(
      () => SubscriptionCubit(sl<SubscriptionRepository>()),
    );
}
