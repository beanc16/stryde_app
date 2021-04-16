import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditsAcknowledgementsScreen extends StatelessWidget
{
  double fontSize = 24;
  double topPaddingSize = 45;
  
  
  
  @override
  Widget build(BuildContext context)
  {
  	return Scaffold(
			appBar: StrydeAppBar(titleStr: "Credits", context: context),
			body: SafeArea(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						getDefaultPadding(),

						Container(
							alignment: Alignment.center,
							child: Text(
								"Programming & Design",
								style: TextStyle(
									decoration: TextDecoration.underline,
									fontSize: fontSize,
									color: StrydeColors.darkBlue,
								),
							),
						),
						Container(
							alignment: Alignment.center,
							child: Text(
								"Chris Bean",
								style: TextStyle(
									fontSize: fontSize,
									color: StrydeColors.darkGray,
								),
							),
						),

						Padding(
							padding: EdgeInsets.only(top: topPaddingSize),
							child: Container(
								alignment: Alignment.center,
								child: Text(
									"UI & Branding Consultation",
									style: TextStyle(
										decoration: TextDecoration.underline,
										fontSize: fontSize,
										color: StrydeColors.darkBlue,
									),
								),
							),
						),
						Container(
							alignment: Alignment.center,
							child: Text(
								"Sara Bustamante",
								style: TextStyle(
									fontSize: fontSize,
									color: StrydeColors.darkGray,
								),
							),
						),

						Container(
							alignment: Alignment.center,
							child: Padding(
								padding: EdgeInsets.only(top: topPaddingSize),
								child: Text(
									"Early Access Teaching & Advising",
									style: TextStyle(
										decoration: TextDecoration.underline,
										fontSize: fontSize,
										color: StrydeColors.darkBlue,
									),
								),
							),
						),
						Container(
							alignment: Alignment.center,
							child: Text(
								"Dennis Gibson & Tom Merrick",
								style: TextStyle(
									fontSize: fontSize,
									color: StrydeColors.darkGray,
								),
							),
						),

						Padding(
							padding: EdgeInsets.only(top: topPaddingSize),
							// TODO: Add MSJ Logo
							child: Container(
								alignment: Alignment.center,
								//child: , // TODO: Add MSJ Logo,
							),
						),
					],
				),
			),
		);
  }
}