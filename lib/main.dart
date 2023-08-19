import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/presentation/router/routes.dart';
import 'package:nsfsheild/presentation/screens/login.dart';
import 'package:nsfsheild/presentation/screens/main_screen.dart';
import 'package:nsfsheild/utils/strings.dart';
import 'package:nsfsheild/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'data/repositories/user_repository.dart';
import 'logic/app_bloc_observer.dart';
import 'logic/cubits/check/check_cubit.dart';
import 'logic/cubits/user/user_cubit.dart';
import 'logic/cubits/user/user_state.dart';


// Import your UserCubit and other necessary dependencies here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set your desired color here
  ));

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RepositoryProvider(
      lazy: false,
      create: (context) => UserRepository(), // Replace with your UserCubit initialization logic
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider<CheckCubit>(
          create: (context) => CheckCubit(),
          ),
        ],
        child: MaterialApp(
        title: AppStrings.kappName,
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        // Define the initial route or widget here
          initialRoute: AppRoutes.signInScreen,
        // For example, you can use a BlocBuilder here:
        home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (oldState, newState) => oldState  is UserInitial && newState is UserAuthenticated,
          builder: (context, state) {
            // Use the state to determine the UI, e.g., login or main screen
            // Replace this with your logic based on UserCubit state
            if (state is UserAuthenticated) {
              return const MainScreen();
            } else {
              return  LoginForm();
            }
          },
        ),
      ),
      ),
    );
  }
}