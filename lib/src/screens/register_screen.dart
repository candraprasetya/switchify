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
        child: VStack(
          [
            'Register'.text.headline5(context).make().p16(),
            _buildRegistrationForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return VStack(
      [
        TextFieldWidget(
          controller: usernameController,
          title: 'Name',
        ),
        8.heightBox,
        TextFieldWidget(
          controller: emailController,
          title: 'Email',
        ),
        8.heightBox,
        TextFieldWidget(
          controller: passController,
          title: 'Password',
          isPassword: true,
        ),
        16.heightBox,
        ButtonWidget(
          onPressed: () {},
          text: 'Register',
        )
      ],
    ).p(16);
  }
}
