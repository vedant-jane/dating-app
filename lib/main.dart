import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'presentation/bloc/home_bloc.dart';
import 'presentation/bloc/home_event.dart';
import 'presentation/pages/main_navigation_page.dart';
import 'presentation/pages/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system navigation and status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final remoteDataSource = UserRemoteDataSourceImpl();
  final userRepository = UserRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(DatingApp(userRepository: userRepository));
}

class DatingApp extends StatelessWidget {
  final UserRepositoryImpl userRepository;

  const DatingApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (context) => HomeBloc(
          userRepository: userRepository,
        )..add(const LoadHomeUsers()),
        child: MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
