import 'package:boilerplate/constants.dart/colors.dart';
import 'package:boilerplate/constants.dart/text_styles.dart';
import 'package:boilerplate/providers/theme_provider.dart';
import 'package:boilerplate/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {super.key,
      this.title,
      this.description,
      required this.confirmBtnText,
      required this.cancelBtnText,
      required this.onConfirmTap,
      required this.onCancelTap,
      this.titleStyle,
      this.descriptionStyle,
      this.btnHeight,
      this.btnWidth});

  final String? title;
  final String? description;
  final String confirmBtnText;
  final String cancelBtnText;
  final VoidCallback onConfirmTap;
  final VoidCallback onCancelTap;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final double? btnHeight;
  final double? btnWidth;

  @override
  State<StatefulWidget> createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            bool isMobile = constraints.maxWidth < 600;
            double defaultButtonWidth = MediaQuery.sizeOf(context).width * 0.05;

            EdgeInsets margin = EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.sizeOf(context).width * (isMobile ? 0.2 : 0.38));
            return ScaleTransition(
              scale: scaleAnimation,
              child: Selector<ThemeProvider, bool>(
                selector: (ctx, themeProvider) => themeProvider.isDarkMode,
                builder: (BuildContext context, isDarkMode, Widget? child) {
                  return Container(
                    margin: margin,
                    decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            color: isDarkMode
                                ? kWhite.withOpacity(0.1)
                                : kBlack.withOpacity(0.01),
                            blurRadius: 8.0,
                            spreadRadius: 10,
                            offset: const Offset(3.0, 5.0),
                          ),
                        ],
                        color: isDarkMode ? kBlack : kWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0))),
                    child: Selector<ThemeProvider, bool>(
                      selector: (ctx, themeProvider) =>
                          themeProvider.isDarkMode,
                      builder:
                          (BuildContext context, isDarkMode, Widget? child) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: widget.title != null,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? kWhite : kBlack,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6)),
                                ),
                                child: Text(
                                  widget.title ?? '',
                                  style: widget.titleStyle ??
                                      text14Bold.copyWith(
                                          color: isDarkMode ? kBlack : kWhite),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Visibility(
                                visible: widget.title != null,
                                child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01)),
                            Visibility(
                              visible: widget.description != null,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 20, left: 15, right: 15),
                                child: Text(widget.description ?? "",
                                    style: widget.descriptionStyle ??
                                        text14Regular,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      width:
                                          widget.btnWidth ?? defaultButtonWidth,
                                      height: widget.btnHeight,
                                      borderRadius: 6,
                                      bgColor: isDarkMode ? kBlack : kWhite,
                                      borderColor: isDarkMode ? kWhite : kBlack,
                                      btnTextStyle: text14Medium,
                                      onPressed: () {
                                        widget.onCancelTap();
                                      },
                                      btnText: widget.cancelBtnText,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      width:
                                          widget.btnWidth ?? defaultButtonWidth,
                                      height: widget.btnHeight,
                                      bgColor: isDarkMode ? kWhite : kBlack,
                                      borderColor: isDarkMode ? kWhite : kBlack,
                                      borderRadius: 6,
                                      onPressed: () {
                                        widget.onConfirmTap();
                                      },
                                      btnText: widget.confirmBtnText,
                                      btnTextStyle: text14Medium.copyWith(
                                       color:  isDarkMode ? kBlack : kWhite
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
