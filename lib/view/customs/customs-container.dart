import 'package:flutter/material.dart';
import 'package:news_app/viewModel/setting-view-model.dart';
import 'package:provider/provider.dart';


class CardContainer extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final BoxShape shape;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  final double blur;
  final DecorationImage image;
  final Gradient gradient;
  final BlendMode blendMode;
  final Alignment alignment;

  const CardContainer({Key key, this.color, this.borderRadius, this.child, this.shape, this.padding, this.margin, this.elevation : 4, this.blur : 4, this.image, this.gradient, this.blendMode, this.alignment,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingViewModel, bool>(
      selector: (_, provider) => provider.isDark(),
      builder: (context, isDark, child) => Container(
        padding: padding ?? EdgeInsets.all(0.0),
        margin: margin ?? EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).backgroundColor,
          borderRadius: borderRadius != null ? borderRadius :  shape == BoxShape.circle ? null : BorderRadius.circular(8.0),
          shape: shape ?? BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                color: !isDark ? Color.fromRGBO(0, 0, 0, 0.1) : Colors.black.withOpacity(0.1),
                offset: Offset(elevation, elevation),
                blurRadius: blur,
            ),
            BoxShadow(
              color: !isDark ? Color.fromRGBO(0, 0, 0, 0.1) : Colors.black.withOpacity(0.1),
                offset: Offset(-elevation, -elevation),
                blurRadius: blur,
            )
          ],
          image: image,
          gradient: gradient,
          backgroundBlendMode: blendMode,
        ),
        alignment: alignment,
        child: child,
      ),
      child: child,
    );
  }
}
