import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marti_location_tracking/product/theme/custom_color_scheme.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';

enum MartiButtonType { standart, secondary, lightBlue, green, outlined, error }

class MartiButton extends StatefulWidget {
  const MartiButton({
    required this.onPressed,
    required this.title,
    super.key,
    this.textStyle,
    this.icon,
    this.iconIsRight = false,
    this.elevation,
    this.style,
    this.buttonType = MartiButtonType.secondary,
    this.backgroundColor,
    this.isActive = true,
    this.width,
    this.height,
    this.isLoading,
    this.loadingColor,
    this.fontSize,
  });
  final VoidCallback onPressed;
  final String title;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool iconIsRight;
  final double? elevation;
  final ButtonStyle? style;
  final bool isActive;
  final Color? backgroundColor;
  final MartiButtonType buttonType;
  final double? width;
  final double? height;
  final bool? isLoading;
  final Color? loadingColor;
  final double? fontSize;

  @override
  State<MartiButton> createState() => _MartiButtonState();
}

class _MartiButtonState extends State<MartiButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {
      return Directionality(
        textDirection: widget.iconIsRight ? TextDirection.rtl : TextDirection.ltr,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ElevatedButton.icon(
            icon: widget.icon,
            label: widget.isLoading ?? false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: widget.loadingColor ?? getLoadingColor(),
                        size: 25,
                      ),
                    ],
                  )
                : _title(context),
            style: widget.style ?? getButtonStyle(context),
            onPressed: widget.isActive ? widget.onPressed : null,
          ),
        ),
      );
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: widget.style ?? getButtonStyle(context),
        onPressed: widget.isActive ? widget.onPressed : null,
        child: widget.isLoading ?? false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: widget.loadingColor ?? getLoadingColor(),
                    size: 25,
                  ),
                ],
              )
            : _title(context),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Center(
      child: Text(widget.title, style: widget.textStyle ?? getTextStyle()),
    );
  }

  ButtonStyle baseButtonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color?>(widget.backgroundColor ?? context.colorScheme.surfaceContainer),
      elevation: WidgetStateProperty.all<double>(widget.elevation ?? 0),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    );
  }

  TextStyle? baseTextStyle() {
    return context.textTheme.titleSmall?.copyWith(
      color: context.appTheme.hintColor,
      fontWeight: FontWeight.w600,
      fontSize: widget.fontSize,
    );
  }

  TextStyle? getTextStyle() {
    final textStyle = baseTextStyle();
    switch (widget.buttonType) {
      case MartiButtonType.secondary:
        return textStyle?.copyWith(color: widget.isActive ? context.colorScheme.onPrimary : context.appTheme.hintColor);
      case MartiButtonType.lightBlue:
        return textStyle?.copyWith(color: context.colorScheme.secondary);
      case MartiButtonType.green:
        return textStyle?.copyWith(color: context.colorScheme.onPrimary);
      case MartiButtonType.standart:
        return textStyle;
      case MartiButtonType.outlined:
        return textStyle?.copyWith(color: context.colorScheme.secondary);
      case MartiButtonType.error:
        return textStyle?.copyWith(color: context.colorScheme.onPrimary);
    }
  }

  Color? getLoadingColor() {
    switch (widget.buttonType) {
      case MartiButtonType.standart:
        return context.colorScheme.primary;

      default:
        return context.colorScheme.surface;
    }
  }

  ButtonStyle getButtonStyle(BuildContext context) {
    var buttonStyle = baseButtonStyle(context);
    switch (widget.buttonType) {
      case MartiButtonType.secondary:
        return buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color?>(widget.isActive ? context.colorScheme.secondary : context.colorScheme.surfaceContainer),
        );
      case MartiButtonType.lightBlue:
        return buttonStyle.copyWith(backgroundColor: WidgetStateProperty.all<Color?>(context.colorScheme.secondaryContainer));
      case MartiButtonType.green:
        return buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color?>(context.colorScheme.success),
        );
      case MartiButtonType.standart:
        return buttonStyle;
      case MartiButtonType.outlined:
        return buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color?>(context.colorScheme.surface),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: context.colorScheme.tertiary)),
        );

      case MartiButtonType.error:
        return buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all<Color?>(context.colorScheme.error),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: context.colorScheme.onPrimary)),
        );
    }
  }
}
