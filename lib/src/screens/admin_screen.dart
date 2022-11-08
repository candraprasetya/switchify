part of 'screens.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Tambah Produk'.text.make(),
        backgroundColor: colorName.secondary,
        elevation: 0.0,
      ),
      body: VStack([
        _buildProductForm(),
        ButtonWidget(
          onPressed: () {},
          text: 'Unggah Produk',
        ).px16()
      ]),
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
    ]).p16();
  }
}
