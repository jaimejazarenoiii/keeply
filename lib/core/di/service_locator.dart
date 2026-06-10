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
import 'package:keeply/features/container/presentation/container_details_delegate.dart';
import 'package:keeply/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:keeply/features/item/presentation/item_details_delegate.dart';
import 'package:keeply/features/node_details/data/node_details_repository_impl.dart';
import 'package:keeply/features/node_details/domain/node_details_repository.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_details_cubit.dart';
import 'package:keeply/features/node_details/presentation/cubit/node_explorer_cubit.dart';
import 'package:keeply/features/space/presentation/space_details_delegate.dart';
import 'package:keeply/features/storage/data/storage_api.dart';
import 'package:keeply/features/storage/data/storage_repository_impl.dart';
import 'package:keeply/features/storage/domain/storage_repository.dart';
import 'package:keeply/features/storage/presentation/bloc/delete_node_cubit.dart';
import 'package:keeply/features/storage/presentation/bloc/move_destination_cubit.dart';
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
    ..registerFactory<DashboardBloc>(
      () => DashboardBloc(sl<StorageRepository>()),
    )
    ..registerFactory<SpacesCubit>(() => SpacesCubit(sl<StorageRepository>()))
    ..registerLazySingleton<NodeDetailsRepository>(
      () => NodeDetailsRepositoryImpl(sl<StorageRepository>()),
    )
    ..registerFactory<NodeDetailsCubit>(
      () => NodeDetailsCubit(sl<NodeDetailsRepository>()),
    )
    ..registerFactory<NodeExplorerCubit>(
      () => NodeExplorerCubit(sl<NodeDetailsRepository>()),
    )
    ..registerLazySingleton<SpaceDetailsDelegate>(() => SpaceDetailsDelegate())
    ..registerLazySingleton<ContainerDetailsDelegate>(
      () => ContainerDetailsDelegate(),
    )
    ..registerLazySingleton<ItemDetailsDelegate>(() => ItemDetailsDelegate())
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
