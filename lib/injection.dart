import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simiko/core/api/api_config.dart';
import 'package:simiko/features/authentication/data/datasources/auth_local_datasource.dart';
import 'package:simiko/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:simiko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:simiko/features/authentication/domain/usecases/check_credential_usecase.dart';
import 'package:simiko/features/authentication/domain/usecases/get_signin_usecase.dart';
import 'package:simiko/features/authentication/domain/usecases/get_signup_usecase.dart';
import 'package:simiko/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:simiko/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:simiko/features/feed/domain/usecases/detail_event_usecase.dart';
import 'package:simiko/features/feed/domain/usecases/like_usecase/toggle_event_like_usecase.dart';
import 'package:simiko/features/feed/domain/usecases/like_usecase/toggle_post_like_usecase.dart';
import 'package:simiko/features/feed/presentation/bloc/likes/like_cubit.dart';
import 'package:simiko/features/feed/presentation/bloc/ukm_feed/ukm_feed_bloc.dart';
import 'package:simiko/features/home/data/datasources/organization/organization_local_datasource.dart';
import 'package:simiko/features/home/data/repositories/organization_repository_impl.dart';
import 'package:simiko/features/home/domain/repositories/organization_repository.dart';
import 'package:simiko/features/home/domain/usecases/organization_usecase.dart';
import 'package:simiko/features/home/presentation/bloc/all_organization/bloc/all_organization_bloc.dart';
import 'package:simiko/features/home/presentation/bloc/detail_organization/detail_organization_bloc.dart';
import 'package:simiko/features/home/presentation/bloc/top_event/top_event_bloc.dart';
import 'package:simiko/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:simiko/features/profile/domain/usecases/profile_usecase.dart';
import 'package:simiko/features/profile/presentation/bloc/profile_bloc.dart';

import 'core/api/api_client.dart';
import 'core/platform/network_info.dart';
import 'features/authentication/data/datasources/auth_remote_datasource.dart';
import 'features/feed/data/datasources/ukm_feed_local_datasource.dart';
import 'features/feed/data/datasources/ukm_feed_remote_datasource.dart';
import 'features/feed/data/repositories/ukm_feed_repository_impl.dart';
import 'features/feed/domain/repositories/ukm_feed_repository.dart';
import 'features/feed/domain/usecases/detail_post_usecase.dart';
import 'features/feed/domain/usecases/like_usecase/get_liked_event_usecase.dart';
import 'features/feed/domain/usecases/like_usecase/get_liked_post_usecase.dart';
import 'features/feed/domain/usecases/like_usecase/is_event_liked_usecase.dart';
import 'features/feed/domain/usecases/like_usecase/is_post_liked_usecase.dart';
import 'features/feed/domain/usecases/ukm_feed_usecase.dart';
import 'features/feed/presentation/bloc/detail_feed/detail_feed_bloc.dart';
import 'features/home/data/datasources/organization/organization_remote_datasource.dart';
import 'features/home/data/datasources/top_event/top_event_local_datasource.dart';
import 'features/home/data/datasources/top_event/top_event_remote_datasource.dart';
import 'features/home/data/repositories/top_event_repository_impl.dart';
import 'features/home/domain/repositories/top_event_repository.dart';
import 'features/home/domain/usecases/detail_organization_usecase.dart';
import 'features/home/domain/usecases/search_organization_usecase.dart';
import 'features/home/domain/usecases/top_event_usecase.dart';
import 'features/home/presentation/bloc/search_organization/search_bloc.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/domain/repositories/profile_repository.dart';

final locator = GetIt.instance;
Future<void> initLocator() async{
    //external
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => Connectivity());
  
    //platform
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: locator()));
  locator.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: ApiConfig.BASE_URL));

  //AUTHENTICATION
  //bloc
  locator.registerFactory(() => AuthenticationBloc(locator(), locator(), locator(), locator()));

  //usecase
  locator.registerLazySingleton(() => GetSignupUsecase(repository: locator()));
  locator.registerLazySingleton(() => GetSigninUsecase(repository: locator()));
  locator.registerLazySingleton(() => CheckCredentialUsecase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUsecase(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(networkInfo: locator(), localDatasource: locator(), remoteDatasource: locator()));

  //datasource
  locator.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl(pref: locator()));
  locator.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(apiClient: locator()));


  //HOME
  //bloc
  locator.registerFactory(() => TopEventBloc(locator()));
  locator.registerFactory(() => AllOrganizationBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => DetailOrganizationBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => TopEventUsecase(repository: locator()));
  locator.registerLazySingleton(() => OrganizationUsecase(repository: locator()));
  locator.registerLazySingleton(() => SearchOrganizationUsecase(repository: locator()));
  locator.registerLazySingleton(() => DetailOrganizationUsecase(repository: locator()));

  //repository
  locator.registerLazySingleton<TopEventRepository>(() => TopEventRepositoryImpl(networkInfo: locator(), localDatasource: locator(), remoteDatasource: locator()));
  locator.registerLazySingleton<OrganizationRepository>(() => OrganizationRepositoryImpl(networkInfo: locator(), localDatasource: locator(), remoteDatasource: locator()));

  //datasource
  locator.registerLazySingleton<TopEventLocalDatasource>(() => TopEventLocalDatasourceImpl(pref: locator()));
  locator.registerLazySingleton<TopEventRemoteDatasource>(() => TopEventRemoteDatasourceImpl(apiClient: locator()));
  locator.registerLazySingleton<OrganizationLocalDatasource>(() => OrganizationLocalDatasourceImpl(pref: locator()));
  locator.registerLazySingleton<OrganizationRemoteDatasource>(() => OrganizationRemoteDatasourceImpl(apiClient: locator()));

  //FEED
  //bloc
  locator.registerFactory(() => UkmFeedBloc(locator()));
  locator.registerFactory(() => DetailFeedBloc(locator(), locator()));
  locator.registerFactory(() => LikeCubit(getLikedPosts: locator(),
        getLikedEvents: locator(),
        togglePostLike: locator(),
        toggleEventLike: locator(),));

  //usecase
  locator.registerLazySingleton(() => UkmFeedUsecase(repository: locator()));
  locator.registerLazySingleton(() => DetailPostUsecase(repository: locator()));
  locator.registerLazySingleton(() => DetailEventUsecase(repository: locator()));

  locator.registerLazySingleton(() => GetLikedPostUsecase(repository: locator()));
  locator.registerLazySingleton(() => GetLikedEventUsecase(repository: locator()));
  locator.registerLazySingleton(() => TogglePostLikeUseCase(locator()));
  locator.registerLazySingleton(() => ToggleEventLikeUseCase(locator()));
  locator.registerLazySingleton(() => IsPostLikedUseCase(locator()));
  locator.registerLazySingleton(() => IsEventLikedUseCase(locator()));

  //repository
  locator.registerLazySingleton<UkmFeedRepository>(() => UkmFeedRepositoryImpl(remoteDatasource: locator(), localDatasource: locator()));

  //datasource
  locator.registerLazySingleton<UkmFeedRemoteDatasource>(() => UkmFeedRemoteDatasourceImpl(apiClient: locator()));
  locator.registerLazySingleton<UkmFeedLocalDatasource>(() => UkmFeedLocalDatasourceImpl(pref: locator()));


  //PROFILE
  //bloc
  locator.registerFactory(() => ProfileBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => ProfileUsecase(repository: locator()));

  //repository
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remoteDatasource: locator()));

  //datasource
  locator.registerLazySingleton<ProfileRemoteDatasource>(() => ProfileRemoteDatasourceImpl(apiClient: locator()));

}