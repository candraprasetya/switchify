part of 'screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: 'Tambah Produk'.text.make(),
        backgroundColor: colorName.accentRed,
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminIsSuccess) {
            Commons()
                .showSnackBar(context, state.message, SnackbarType.success);
            productNameController.clear();
            productPriceController.clear();
            BlocProvider.of<ProductPictureCubit>(context).resetImage();
            BlocProvider.of<ListProductBloc>(context).add(FetchProductList());
          }
        },
        builder: (context, state) {
          if (state is AdminIsLoading) {
            return const CircularProgressIndicator().centered();
          }
          return VStack([
            _buildProductForm(),
            ButtonWidget(
              color: colorName.primary,
              text: 'Tambah Produk',
              onPressed: () {
                BlocProvider.of<AdminBloc>(context).add(AddProduct(
                  name: productNameController.text,
                  price: double.parse(productPriceController.text),
                ));
              },
            ).pSymmetric(h: 16)
          ]);
        },
      ),
    );
  }

  Widget _buildProductForm() {
    return VStack([
      TextFieldWidget(
        title: 'Name',
        controller: productNameController,
      ),
      8.heightBox,
      TextFieldWidget(
        title: 'Price',
        controller: productPriceController,
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsSuccess) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ZStack(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      state.file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductPictureCubit>(context).getImage();
                    },
                    icon: const Icon(Icons.photo_rounded),
                  )
                      .box
                      .color(colorName.white.withOpacity(.8))
                      .roundedFull
                      .make()
                ],
                alignment: Alignment.center,
              ),
            );
          }
          return IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).getImage();
            },
            icon: const Icon(Icons.photo_rounded),
          );
        },
      ),
    ]).p16();
  }
}
