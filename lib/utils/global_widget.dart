import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget dot(double widhtNya, double heightNya, bool active) {
  return active
      ? Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.lightBlue)),
          width: widhtNya,
          height: heightNya,
        )
      : Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
              border: Border.all(color: Colors.lightBlue)),
          width: widhtNya,
          height: heightNya,
        );
}

Widget line(double width, height, Color colors) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      margin: EdgeInsets.all(10),
      width: width,
      height: height,
      color: colors,
    ),
  );
}

//Header Logo

Widget headerLogo(
  BuildContext context,
  String image,
  double heightPercent,
  double widthPercent,
) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Center(
      child: Image(
        image: AssetImage(image),
        width: MediaQuery.of(context).size.width * widthPercent,
        height: MediaQuery.of(context).size.height * heightPercent,
      ),
    ),
  );
}

Widget cardbg() {
  return Container(
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ))));
}

void showSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String msg) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(msg),
  ));
}

Widget backArrow(BuildContext context, Color color, String title){
  return Row(
    children: [
      GestureDetector(
        child: Align(alignment: Alignment.topLeft,child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: color,
            )
        )),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      Expanded(child: Align( alignment : Alignment.topLeft, child: Text(title, style: TextStyle(color: color, fontSize: 18),),))
    ],
  );
}
