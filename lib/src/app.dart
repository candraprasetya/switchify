import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/blocs/blocs.dart';
import 'package:switchify/src/blocs/detail_product/detail_product_bloc.dart';
import 'package:switchify/src/cubits/cubits.dart';
import 'package:switchify/src/utilities/utilities.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ProductPictureCubit()),
        BlocProvider(create: (context) => ListProductBloc()),
        BlocProvider(create: (context) => DetailProductBloc()),
        BlocProvider(
            create: (context) =>
                AdminBloc(BlocProvider.of<ProductPictureCubit>(context))),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
