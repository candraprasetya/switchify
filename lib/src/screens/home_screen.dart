part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserIsFailed) {
            Commons().showSnackBar(context, state.message);
          } else if (state is UserIsLogOut) {
            context.go(routeName.login);
          }
        },
        builder: (context, state) {
          if (state is UserIsLoading) {
            return const CircularProgressIndicator().centered();
          } else if (state is UserIsSuccess) {
            return VStack([
              'Selamat Datang ${state.data.username}'.text.makeCentered(),
              16.heightBox,
              ButtonWidget(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(LogOutUser());
                },
                text: 'Log Out',
              )
            ]);
          }
          return 0.heightBox;
        },
      ).p16().centered(),
    );
  }
}
