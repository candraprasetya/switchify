part of 'widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final bool? isPassword;
  final bool? isEnabled;
  const TextFieldWidget(
      {super.key,
      this.controller,
      this.title,
      this.isPassword = false,
      this.isEnabled = true});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.isEnabled!,
      textAlignVertical: TextAlignVertical.center,
      obscureText: (widget.isPassword!) ? isObscure : false,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.title,
          suffixIcon: (widget.isPassword!)
              ? IconButton(
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  })
              : 0.heightBox),
    ).pSymmetric(h: 12).box.white.withRounded(value: 10).make();
  }
}
