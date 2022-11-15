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
                  24.heightBox,
                  _buildListProduct().expand(),
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
              backgroundImage: (data.photoProfile!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(data.photoProfile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ).onTap(() {
              context.go(routeName.adminPath);
            }),
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

  Widget _buildListProduct() {
    return BlocConsumer<ListProductBloc, ListProductState>(
      listener: (context, state) {
        if (state is ListProductIsFailed) {
          Commons().showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductIsLoading) {
          //Loading Widget
          return CircularProgressIndicator();
        }
        if (state is ListProductIsSuccess) {
          //List Product Widget
          final data = state.products;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: VStack([
                  Image.network(
                    data[index].picture!,
                    fit: BoxFit.cover,
                  ),
                  data[index].name!.text.bodyText1(context).make(),
                  data[index].price!.text.bodyText1(context).make(),
                ]),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
