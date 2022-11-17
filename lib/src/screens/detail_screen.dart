part of 'screens.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          if (state is DetailProductIsSuccess) {
            return VStack([
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(state.data.picture!),
              ),
              state.data.name!.text.size(16).bold.make(),
              HStack([
                'Variant Produk'.text.make(),
                16.widthBox,
                HStack(state.data.variant!
                    .map((e) =>
                        VxBox(child: e.text.color(colorName.white).make())
                            .color(colorName.grey)
                            .p4
                            .rounded
                            .make()
                            .pOnly(right: 4))
                    .toList())
              ])
            ]);
          }
          return Container();
        },
      ),
    );
  }
}
