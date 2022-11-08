part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
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
              return VStack(
                [
                  _buildAppBar(context, state.data),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          //USER Profile
          HStack([
            VxCircle(
              radius: 56,
              backgroundImage: DecorationImage(
                image: NetworkImage(data.photoProfile!),
                fit: BoxFit.cover,
              ),
            ),
            16.widthBox,
            "Selamat Datang,\n".richText.size(11).withTextSpanChildren([
              data.username!.textSpan.size(14).bold.make(),
            ]).make(),
          ]).expand(),

          //ICON Logout
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: colorName.accentRed,
            ),
          )
        ],
        // alignment: MainAxisAlignment.spaceBetween,
        // axisSize: MainAxisSize.max,
      ),
    ).make();
  }

  //TODO: Create Product Grid

}
