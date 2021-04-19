import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ComingSoonWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: Colors.black.withOpacity(0.6),
      alignment: Alignment.center,
      child: Text(
        "Coming Soon...",
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
        ),
      ),
    );
  }
}