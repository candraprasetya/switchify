part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const home = '/home';
  static const admin = 'admin';
  static const adminPath = '/home/admin';
}

final GoRouter router = GoRouter(
  initialLocation: routeName.splash,
  routes: <GoRoute>[
    GoRoute(
      path: routeName.splash,
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          BlocProvider.of<UserBloc>(context).add(FetchUserData());
          BlocProvider.of<ListProductBloc>(context).add(FetchProductList());
          return routeName.home;
        } else {
          return routeName.login;
        }
      },
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
        path: routeName.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: routeName.admin,
            builder: (BuildContext context, GoRouterState state) {
              return const AdminScreen();
            },
          ),
        ]),
    GoRoute(
      path: routeName.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: routeName.register,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
  ],
);
