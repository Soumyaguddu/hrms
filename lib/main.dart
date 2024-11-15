import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/auth/cubit/auth_cubit.dart';

import 'blocs/internet_cubit/internet_cubit.dart';
import 'blocs/routes/Routes.dart';
import 'blocs/ui/home/logic/home_cubit.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
        create: (context) => InternetCubit(),
      ),
        BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),BlocProvider<HomeSalaryCubit>(
        create: (context) => HomeSalaryCubit(),
      ),],
      child: MaterialApp(
        navigatorKey: navigatorKey, // Set the global navigator key
        title: 'HRMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.onGenerate,
        initialRoute: Routes.splash,
        //home: const HomeUpdatePage(),
      ),
    );
  }

}


