import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts/core/app_them.dart';
import 'package:flutter_posts/core/bloc_observer.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_cubit.dart';
import 'features/posts/presentation/bloc/posts/posts_cubit.dart';
import 'core/injiction_container.dart' as di;
import 'features/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => di.sl<GetAllPostsCubit>()..getAllPosts()),
          BlocProvider(create: (context) => di.sl<AddDeleteUpdateCubit>()),
        ],
        child: MaterialApp(
          theme: appTheme,
          title: 'Posts App',
          debugShowCheckedModeBanner: false,
          home: const SplashView(),
        ));
  }
}
