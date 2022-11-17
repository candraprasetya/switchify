part of 'screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  final TextEditingController productVariantsController =
      TextEditingController();

  void reset() {
    //kita hapus name controller
    productNameController.clear();
    //kita hapus price controller
    productPriceController.clear();
    //kita hapus desc controller
    productDescController.clear();
    //kita hapus variant controller
    productVariantsController.clear();
    //kita hapus state image picker
    BlocProvider.of<ProductPictureCubit>(context).resetImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        reset();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Tambah Produk'.text.make(),
          backgroundColor: colorName.secondary,
          elevation: 0.0,
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminIsSuccess) {
              reset();
              Commons().showSnackBar(context, state.message);
            } else if (state is AdminIsFailed) {
              Commons().showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            return VStack([
              _buildProductForm(),
              ButtonWidget(
                onPressed: () {
                  BlocProvider.of<AdminBloc>(context).add(AddProduct(
                    name: productNameController.text,
                    price: double.parse(productPriceController.text),
                    desc: productDescController.text,
                    variants: productVariantsController.text,
                  ));
                },
                isLoading: (state is AdminIsLoading) ? true : false,
                text: 'Unggah Produk',
              ).px16()
            ]);
          },
        ),
      ),
    );
  }

  //TODO: Widget Form (Nama Produk DONE, Harga DONE, Poto)
  Widget _buildProductForm() {
    return VStack([
      TextFieldWidget(
        controller: productNameController,
        title: 'Nama Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productPriceController,
        title: 'Harga Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productDescController,
        title: 'Deskripsi Produk',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: productVariantsController,
        title: 'Variant Produk',
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded) {
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
                    icon: Icon(Icons.image),
                  )
                      .box
                      .color(colorName.white.withOpacity(.8))
                      .roundedFull
                      .make(),
                ],
                alignment: Alignment.center,
              ),
            );
          }
          return IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).getImage();
            },
            icon: Icon(Icons.image),
          );
        },
      )
    ]).p16();
  }
}
