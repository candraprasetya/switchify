part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.background,
      body: SafeArea(
        child: VStack([
          _buildHeader(context),
          _buildHelloUser(context),
          _listProduct(),
        ]),
      ),
    );
  }

  Widget _listProduct() {
    return BlocListener<AdminBloc, AdminState>(listener: (context, state) {
      if (state is AdminIsSuccess) {
        Commons().showSnackBar(context, state.message, SnackbarType.success);
        BlocProvider.of<ListProductBloc>(context).add(FetchProductList());
      }
    }, child: BlocBuilder<ListProductBloc, ListProductState>(
      builder: (context, state) {
        if (state is ListProductIsSuccess) {
          return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<ListProductBloc>(context)
                        .add(FetchProductList());
                    BlocProvider.of<UserBloc>(context).add(FetchUserData());
                  },
                  child: (state.products.isEmpty)
                      ? 'Belum ada Produk'.text.makeCentered()
                      : GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) =>
                              ProductWidget(model: state.products[index]),
                          itemCount: state.products.length))
              .p16()
              .hFull(context)
              .expand();
        }
        return Container();
      },
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return HStack(
      [
        _buildSearch(context),
        _buildProfilePicture(),
      ],
      alignment: MainAxisAlignment.spaceBetween,
      axisSize: MainAxisSize.max,
    ).p16();
  }

  Widget _buildSearch(BuildContext context) {
    return const Icon(Icons.search).onTap(() {});
  }

  Widget _buildHelloUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserIsSuccess) {
          return VStack([
            'Welcome,'.text.headline6(context).bold.make(),
            4.heightBox,
            state.userModel.username!.text
                .bodyText1(context)
                .normal
                .color(colorName.grey)
                .make(),
          ]);
        }
        return 0.heightBox;
      },
    ).pSymmetric(h: 16);
  }

  Widget _buildProfilePicture() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserIsSuccess) {
          return CircleAvatar(
            radius: 20,
            backgroundColor: colorName.accentBlue,
            backgroundImage: state.userModel.photoProfile!.isEmptyOrNull
                ? null
                : NetworkImage(state.userModel.photoProfile!),
            child: state.userModel.photoProfile!.isEmpty
                ? state.userModel.username![0].text.make()
                : 0.widthBox,
          ).onTap(() {
            context.go(routeName.adminPath);
          });
        }
        return 0.heightBox;
      },
    );
  }
}
