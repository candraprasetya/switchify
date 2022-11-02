import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/blocs/blocs.dart';
import 'package:switchify/src/utilities/utilities.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
