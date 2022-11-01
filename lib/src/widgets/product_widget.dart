part of 'widgets.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel model;

  const ProductWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: VxBox(
        child: VStack([
          ZStack(
            [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: (model.picture!.isEmpty)
                      ? 0.heightBox
                      : Image.network(
                          model.picture!,
                          fit: BoxFit.cover,
                        )),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserIsSuccess) {
                    return (state.userModel.admin!)
                        ? IconButton(
                            onPressed: () {
                              BlocProvider.of<AdminBloc>(context)
                                  .add(DeleteProduct(model.id));
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: colorName.accentRed,
                            ))
                        : 0.heightBox;
                  }
                  return 0.heightBox;
                },
              )
            ],
            alignment: Alignment.topRight,
          ),
          4.heightBox,
          VStack([
            model.name!.text.bodyText1(context).ellipsis.maxLines(2).make(),
            4.heightBox,
            Commons().convertToIdr(model.price!, 0).text.size(10).make()
          ]).p8()
        ]),
      ).color(colorName.white).make(),
    );
  }
}
