import 'package:Stryde/components/strydeHelpers/constants/StrydeUserStorage.dart';
import 'package:Stryde/components/toggleableWidget/EmptyWidget.dart';
import 'package:Stryde/screens/loggedOut/StartupScreen.dart';
import 'package:Stryde/utilities/NavigateTo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';


class StrydeAppBar extends AppBar
{
  StrydeAppBar({
    required String titleStr,
    BuildContext? context,
  }) :

      super(
        backgroundColor: StrydeColors.lightBlue,
        actions: [    // Trailing Icons
          ((context != null) ?
          // If context exists
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: ()
            {
              StrydeUserStorage.reset();
              NavigateTo.screenRemoveAllBacks(context, () => StartupScreen());
            },
          ) :
          // If context is empty
          EmptyWidget()),
        ],

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
