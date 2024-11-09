import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/internet_cubit/internet_cubit.dart';
import 'blocs/routes/Routes.dart';
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
      providers: [  BlocProvider<InternetCubit>(
        create: (context) => InternetCubit(),
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


