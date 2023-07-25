import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/data/repos/auth_repo_impl.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/authentication/domain/repos/auth_repo.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/domain/use_cases/get_product_remote.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'core/http_request/http_request_interceptor.dart';
import 'core/http_request/remote_data_request.dart';
import 'feature/authentication/data/data_source/auth_remote_data_source.dart';
import 'feature/authentication/domain/use_cases/request_user_login.dart';
import 'feature/product/data/data_source/product_remote_data_source.dart';
import 'feature/product/data/repos/product_repo_impl.dart';
import 'feature/product/domain/auth_storage/auth_storage.dart';
import 'feature/product/domain/repos/product_repo.dart';

final getIt = GetIt.I;
void configureDependencies() {
  // Registering FlutterSecureStorage
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // Registering AuthStorage
  getIt.registerLazySingleton<AuthStorage>(() => AuthStorage(getIt<FlutterSecureStorage>()));


  getIt.registerFactory<InterceptedHttp>(() => InterceptedHttp.build(interceptors: [
          HttpRequestInterceptor(getIt<AuthStorage>()),
      ]));
  
  // Registering HTTP request
  getIt.registerLazySingleton<RemoteDataRequest>(() => RemoteDataRequest(getIt<InterceptedHttp>()));

  // Registring Product DataSource, Repo, and Use Cases 
  getIt.registerSingleton<ProductRemoteDataSource>(ProductRemoteDataSourceImpl(getIt<RemoteDataRequest>()));
  getIt.registerSingleton<ProductRepo>(ProductRepoImpl(getIt<ProductRemoteDataSource>()));
  getIt.registerFactory<GetProductRemote>(() => GetProductRemote(getIt<ProductRepo>()));

  // Registring Auth DataSource, Repo, and Use Cases 
  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(getIt<RemoteDataRequest>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt<AuthRemoteDataSource>(), getIt<AuthStorage>()));
  getIt.registerFactory<RequestUserLogin>(() => RequestUserLogin(getIt<AuthRepo>()));
} 
