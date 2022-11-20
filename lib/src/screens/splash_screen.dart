part of 'screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        'Switchify'.text.bold.make(),
      ]).centered(),
    );
  }
}

//VStack == Column
//HStack == Row
//ZStack == Stack
