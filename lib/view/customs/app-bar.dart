import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color titleColor;
  final String title;

  const CustomAppbar(
      {Key key, this.title, this.backgroundColor, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.blue,
      centerTitle: true,
      leading: Icon(
        Icons.keyboard_arrow_down,
        color: titleColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

class CustomSliverAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color titleColor;
  final String title;
  final String imageUrl;
  final Key heroKey;

  const CustomSliverAppbar(
      {Key key,
      this.title,
      this.backgroundColor,
      this.titleColor,
      this.imageUrl, this.heroKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(8.0),
        background: Hero(
          tag: heroKey,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            colorBlendMode: BlendMode.multiply,
            color: Colors.black26,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              color: backgroundColor ?? Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
