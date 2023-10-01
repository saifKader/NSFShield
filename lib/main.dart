import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/logic/cubits/check/transaction_cubit.dart';
import 'package:nsfsheild/presentation/animations/splash_screen.dart';
import 'package:nsfsheild/presentation/animations/splash_screen2.dart';
import 'package:nsfsheild/presentation/screens/scan_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizing/sizing_builder.dart';
import 'data/providers/service_locator.dart';
import 'data/repositories/user_repository.dart';
import 'logic/app_bloc_observer.dart';
import 'logic/cubits/check/check_cubit.dart';
import 'logic/cubits/user/user_cubit.dart';
import 'logic/cubits/user/user_state.dart';
import 'presentation/router/routes.dart';
import 'presentation/screens/login.dart';
import 'presentation/screens/main_screen.dart';
import 'utils/strings.dart';
import 'utils/theme.dart';

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
      create: (context) => UserRepository(),
      // Replace with your UserRepository initialization logic
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider<CheckCubit>(
            create: (context) => CheckCubit(),
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(context.read<UserRepository>())
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
            buildWhen: (oldState, newState) =>
                oldState is UserInitial && newState is UserAuthenticated,
            builder: (context, state) {
              // Use the state to determine the UI, e.g., login or main screen
              // Replace this with your logic based on UserCubit state
              if (state is UserAuthenticated) {
                return SizingBuilder(
                   builder: () => const MainScreen(),
                );
              } else {
                return SizingBuilder( // Wrap with SizingBuilder
                  builder: () => SplashScreen2(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
