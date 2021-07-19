import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geshin_app/bloc/genshin_data_bloc.dart';
import 'package:geshin_app/inject/inject.dart';
import 'package:geshin_app/observer/genshin_app_observer.dart';
import 'package:geshin_app/presentation/screens/home_screen/home_screen.dart';

Future<void> main() async {
  Bloc.observer = GenshinAppObserver();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => inject<GenshinDataBloc>(),
        )
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
