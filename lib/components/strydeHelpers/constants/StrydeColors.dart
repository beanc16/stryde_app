import 'dart:ui';
import 'package:flutter/material.dart';

class StrydeColors
{
  // Visual Color Palette:
  // https://color.adobe.com/Stryde-color-theme-17211047
  static const Color lightBlue = Color.fromRGBO(23, 177, 255, 1);
  static const Color darkBlue = Color.fromRGBO(32, 123, 168, 1);
  static const Color purple = Color.fromRGBO(139, 64, 230, 1);
  static const Color lightGray = Color.fromRGBO(146, 148, 174, 1);
  static const Color darkGray = Color.fromRGBO(109, 110, 131, 1);

  // Miscellaneous
  static const Color darkRedError = Color.fromRGBO(139, 0, 0, 1);
  static const Color darkGreenSuccess = Color.fromRGBO(0, 139, 0, 1);
  
  
  
  // MaterialColors
  static MaterialColor lightBlueMat = lightBlue.toMaterialColor();
  static MaterialColor darkBlueMat = darkBlue.toMaterialColor();
  static MaterialColor purpleMat = purple.toMaterialColor();
  static MaterialColor lightGrayMat = lightGray.toMaterialColor();
  static MaterialColor darkGrayMat = darkGray.toMaterialColor();
  
  static MaterialColor darkRedErrorMat = darkRedError.toMaterialColor();
  static MaterialColor darkGreenSuccessMat = darkGreenSuccess.toMaterialColor();
}



extension ColorHelpers on Color
{
  String toHexString()
  {
    String radixStr = "0x" + value.toRadixString(16);
    return radixStr.padLeft(8, '0');
  }
  
  int toHex()
  {
    String hexStr = toHexString();
    return int.parse(hexStr);
  }
  
  MaterialColor toMaterialColor()
  {
    Map<int, Color> colorMap = {
	    50: Color.fromRGBO(this.red, this.green, this.blue, 0.1),
	  };
	
    double opacity = 0.2;
    for (int i = 100; i <= 900 && opacity <= 1; i += 100)
    {
      colorMap[i] = Color.fromRGBO(this.red, this.green, this.blue, opacity);
      opacity += 0.1;
    }

    return MaterialColor(this.toHex(), colorMap);
  }
}
