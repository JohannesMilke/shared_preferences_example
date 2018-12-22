import 'package:advent22_shared_preferences/data/data.dart';
import 'package:advent22_shared_preferences/model/color_box.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorBoxWidget extends StatefulWidget {
  @override
  ColorBoxWidgetState createState() => ColorBoxWidgetState();
}

class ColorBoxWidgetState extends State<ColorBoxWidget> {
  static const String colorBoxKey = 'colorBox';
  ColorBox colorBox;

  @override
  void initState() {
    super.initState();

    colorBox = colorBoxes.first;
    loadColorBox();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colorBoxes
                .map((colorBox) => buildColoredBox(context, colorBox))
                .toList(),
          ),
          SizedBox(height: 24.0),
          Text(
            'Shared Preferences',
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: colorBox.color),
          )
        ],
      );

  Widget buildColoredBox(BuildContext context, ColorBox colorBox) =>
      GestureDetector(
        onTap: () => onTap(colorBox),
        child: Container(
          child: Center(
            child: Text(
              colorBox.name,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
          ),
          width: 96.0,
          height: 96.0,
          color: colorBox.color,
        ),
      );

  Future onTap(ColorBox colorBox) async {
    setState(() => this.colorBox = colorBox);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(colorBoxKey, colorBox.name);
  }

  Future loadColorBox() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String storedColorBoxName = preferences.getString(colorBoxKey);

    if (storedColorBoxName == null) return;

    final ColorBox currentColorBox = colorBoxes
        .firstWhere((colorBox) => colorBox.name == storedColorBoxName);

    setState(() {
      colorBox = currentColorBox;
    });
  }
}
