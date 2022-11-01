part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginIsFailed) {
            Commons().showSnackBar(context, state.message, SnackbarType.error);
          } else if (state is LoginIsSuccess) {
            BlocProvider.of<ListProductBloc>(context).add(FetchProductList());
            context.go(routeName.home);
          }
        },
        child: VStack(
          [
            'Masuk'.text.bold.headline5(context).make().px16(),
            _buildLoginForm().py24(),
            _buildButton()
          ],
        ),
      ).scrollVertical().centered(),
    ));
  }

  Widget _buildLoginForm() {
    return VStack([
      TextFieldWidget(
        title: 'Email',
        controller: emailController,
      ),
      8.heightBox,
      TextFieldWidget(
        title: 'Password',
        controller: passController,
        isPassword: true,
      )
    ]).pSymmetric(h: 16);
  }

  Widget _buildButton() {
    return VStack([
      ButtonWidget(
        onPressed: () {
          BlocProvider.of<LoginBloc>(context)
              .add(Login(emailController.text, passController.text));
        },
        text: 'Login',
      ),
      TextButton(
        onPressed: () {
          context.go(routeName.register);
        },
        child: 'Belum punya akun? Daftar disini'
            .text
            .color(colorName.accentBlue)
            .make(),
      ).centered()
    ]).pSymmetric(h: 16);
  }
}
