import 'package:flutter_posts/core/network/network_info.dart';
import 'package:flutter_posts/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_posts/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_posts/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:flutter_posts/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_posts/features/posts/domain/usecases/add_post.dart';
import 'package:flutter_posts/features/posts/domain/usecases/delet_post.dart';
import 'package:flutter_posts/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_posts/features/posts/domain/usecases/update_post.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_cubit.dart';
import 'package:flutter_posts/features/posts/presentation/bloc/posts/posts_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //-- FeaturePosts

  // bloc
  sl.registerFactory(() => GetAllPostsCubit(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateCubit(
      addPostUseCase: sl(), deletPostUseCase: sl(), updatePostUseCase: sl()));

  //  UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletPostUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(() => PostsRepositoryImpl(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      networkInfo: sl()));

  // Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
