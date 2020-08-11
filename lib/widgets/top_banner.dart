import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({@required this.screenSize});

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height / 3,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: BannerClipper(true),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          ClipPath(
            clipper: BannerClipper(false),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColorLight,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  bool isContour;

  BannerClipper(this.isContour);

  @override
  Path getClip(Size size) {
    double offset = isContour ? size.height / 3.2 : size.height / 3;
  
    var path = Path();
    path.lineTo(0, size.height - offset);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - offset,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}