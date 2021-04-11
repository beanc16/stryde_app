import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeAppBar extends AppBar
{
  StrydeAppBar({required String titleStr}) :

      super(
        backgroundColor: StrydeColors.lightBlue,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              // SVG Logo
              child: SvgPicture.asset(
                //"images/strydeLogoClean.svg",       // This works on website
                "assets/images/strydeLogoClean.svg",  // This works on android
                semanticsLabel: "Stryde Logo",

                fit: BoxFit.contain,
                height: 40,

                placeholderBuilder: (BuildContext context)
                {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: 8,
                      bottom: 8,
                    ),
                  );
                },
              ),

              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 8,
              ),
            ),

            // Display Text
            Text(titleStr),
          ],
        )
      );
}
