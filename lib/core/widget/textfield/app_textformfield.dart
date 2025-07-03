import '../../exports.dart';

class AppTextFormField extends StatelessWidget {
  AppTextFormField({
    required this.hintText,
    this.onlyNumber = false,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.enabled = true,
    this.maxLines,
    this.maxLength,
    super.key});

  final bool onlyNumber;
  bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String hintText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? suffixIcon,prefixIcon;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLength,maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorHeight: 14,
      cursorColor: AppColor.primaryColor,
      style: Theme.of(context).textTheme.titleMedium,
      inputFormatters: onlyNumber ? <TextInputFormatter>[
         FilteringTextInputFormatter.digitsOnly,
      ] : null,
      decoration: InputDecoration(
        hintText: hintText,

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      onTap: onTap,
      onChanged: onChanged,
      focusNode: focusNode,
      enabled: enabled,
    );
  }
}
