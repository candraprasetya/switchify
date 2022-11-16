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
            return state.data.name!.text.make();
          }
          return Container();
        },
      ),
    );
  }
}
