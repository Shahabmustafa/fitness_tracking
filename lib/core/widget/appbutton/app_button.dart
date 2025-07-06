import '../../exports.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onTap,
    this.height = 50,
    this.width = double.infinity,
    this.loading = false,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColor.white,
      fontSize: 16,
    ),
    this.color = AppColor.primaryColor,
    super.key});

  final String text;
  final double? height;
  final double? width;
  final bool loading;
  final VoidCallback onTap;
  final Color color;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          border: Constant.border,
        ),
        child: loading ?
        const Center(child: SizedBox(height: 25,width: 25,child: CircularProgressIndicator(color: AppColor.white,))) :
        Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
