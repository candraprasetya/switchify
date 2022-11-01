part of 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterIsFailed) {
            Commons().showSnackBar(context, state.message, SnackbarType.error);
          } else if (state is RegisterIsSuccess) {
            BlocProvider.of<ListProductBloc>(context).add(FetchProductList());
            context.go(routeName.home);
          }
        },
        child: VStack(
          [
            'Daftar'.text.bold.headline5(context).make().px16(),
            _buildRegistrationForm().py24(),
            _buildButton()
          ],
        ),
      ).scrollVertical().centered(),
    ));
  }

  Widget _buildRegistrationForm() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        bool enableTextField = (state is RegisterIsLoading) ? false : true;
        return VStack([
          TextFieldWidget(
            isEnabled: enableTextField,
            controller: usernameController,
            title: "Username",
          ),
          8.heightBox,
          TextFieldWidget(
            isEnabled: enableTextField,
            title: 'Email',
            controller: emailController,
          ),
          8.heightBox,
          TextFieldWidget(
            isEnabled: enableTextField,
            title: 'Password',
            controller: passController,
            isPassword: true,
          )
        ]);
      },
    ).pSymmetric(h: 16);
  }

  Widget _buildButton() {
    return VStack([
      BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return ButtonWidget(
            isLoading: (state is RegisterIsLoading) ? true : false,
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(Register(
                  usernameController.text,
                  emailController.text,
                  passController.text));
            },
            text: 'Daftar',
          );
        },
      ),
      TextButton(
        onPressed: () {
          context.go(routeName.login);
        },
        child: 'Sudah punya akun? Masuk disini'
            .text
            .color(colorName.accentBlue)
            .make(),
      ).centered()
    ]).pSymmetric(h: 16);
  }
}
