import 'package:boilerplate/constants.dart/colors.dart';
import 'package:boilerplate/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.btnText,
      this.btnTextStyle,
      this.onPressed,
      this.bgColor,
      this.borderColor,
      this.width,
      this.height,
      this.showArrow,
      this.borderRadius,
      this.showLoader,
      this.prefixIcon,
      this.disableUpperCase,
      this.padding});

  @override
  State<CustomButton> createState() => _CustomButtonState();
  final String btnText;
  final TextStyle? btnTextStyle;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final bool? showArrow;
  final double? borderRadius;
  final bool? showLoader;
  final Widget? prefixIcon;
  final bool? disableUpperCase;
  final EdgeInsets? padding;
}

class _CustomButtonState extends State<CustomButton> {
  bool _isButtonDisabled = false;
  Duration debounceTime = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Selector<ThemeProvider, bool>(
        selector: (context, themeProvider) => themeProvider.isDarkMode,
        builder: (BuildContext context, isDarkMode, Widget? child) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 40,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: widget.bgColor ?? (isDarkMode ? kWhite : kBlack),
                border: Border.all(
                  color: widget.borderColor ?? Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 0.0)),
              ),
              alignment: Alignment.center,
              child: (widget.showLoader ?? false)
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: isDarkMode ? kBlack : kWhite,
                        strokeWidth: 2,
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.prefixIcon ?? const SizedBox(),
                        Text(widget.btnText,
                            textAlign: TextAlign.center,
                            style: widget.btnTextStyle ??
                                TextStyle(color: isDarkMode ? kBlack : kWhite)),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  _onTap() {
    if (!_isButtonDisabled) {
      setState(() {
        _isButtonDisabled = true;
      });
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
      Future.delayed(debounceTime, () {
        if (mounted) {
          setState(() {
            _isButtonDisabled = false;
          });
        }
      });
    }
  }
}
