import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/blocs/blocs.dart';
import 'package:switchify/src/cubits/cubits.dart';
import 'package:switchify/src/utilities/utilities.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                RegisterBloc(BlocProvider.of<UserBloc>(context))),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(
          create: (context) => LoginBloc(BlocProvider.of<UserBloc>(context)),
        ),
        BlocProvider(
          create: (context) => ProductPictureCubit(),
        ),
        BlocProvider(
          create: (context) =>
              AdminBloc(BlocProvider.of<ProductPictureCubit>(context)),
        ),
        BlocProvider(
          create: (context) => ListProductBloc(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
