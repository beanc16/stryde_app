import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:Stryde/components/strydeHelpers/widgets/nav/StrydeAppBar.dart';
import 'package:Stryde/components/toggleableWidget/EmptyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditsAcknowledgementsScreen extends StatelessWidget
{
  double _fontSize = 19;
  double _topPaddingSize = 45;
  double _iconSize = 20;
  double _iconPadding = 10;
  late Icon _programmingDesignIcon;
	late Icon _uiBrandingConsultationIcon;
	late Icon _teachingAdvisingIcon;

	CreditsAcknowledgementsScreen()
	{
		_programmingDesignIcon = Icon(
			Icons.developer_mode_rounded,
			color: StrydeColors.darkBlue,
			size: _iconSize,
		);
		_uiBrandingConsultationIcon = Icon(
			Icons.design_services_rounded,
			color: StrydeColors.darkBlue,
			size: _iconSize,
		);
		_teachingAdvisingIcon = Icon(
			Icons.school_rounded,
			color: StrydeColors.darkBlue,
			size: _iconSize,
		);
	}

  
  
  @override
  Widget build(BuildContext context)
  {
  	return Scaffold(
			appBar: StrydeAppBar(titleStr: "Credits"),
			body: Container(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Expanded(
							flex: 3,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									//Padding(padding: EdgeInsets.only(top: 275)),
									//getDefaultPadding(),

									//Flexible(flex: 1, child: EmptyWidget()),
									Flexible(
										flex: 2,
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														_programmingDesignIcon,
														Padding(
															padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
															child: Text(
																"Programming & Design",
																style: TextStyle(
																	decoration: TextDecoration.underline,
																	fontSize: _fontSize,
																	color: StrydeColors.darkBlue,
																),
															),
														),
														_programmingDesignIcon,
													]
												),
												Container(
													alignment: Alignment.center,
													child: Text(
														"Chris Bean",
														style: TextStyle(
															fontSize: _fontSize,
															color: StrydeColors.darkGray,
														),
													),
												)
											]
										),
									),
									//Padding(padding: EdgeInsets.only(top: _topPaddingSize)),
									Flexible(flex: 1, child: EmptyWidget()),
									Flexible(
										flex: 2,
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														_uiBrandingConsultationIcon,
														Padding(
															padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
															child: Text(
																"UI & Branding Consultation",
																style: TextStyle(
																	decoration: TextDecoration.underline,
																	fontSize: _fontSize,
																	color: StrydeColors.darkBlue,
																),
															),
														),
														_uiBrandingConsultationIcon,
													]
												),
												Container(
													alignment: Alignment.center,
													child: Text(
														"Sara Bustamante",
														style: TextStyle(
															fontSize: _fontSize,
															color: StrydeColors.darkGray,
														),
													),
												),
											]
										),
									),
									Flexible(flex: 1, child: EmptyWidget()),
									Flexible(
										flex: 2,
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														_teachingAdvisingIcon,
														Padding(
															padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
															child: Text(
																"Early Access\nTeaching & Advising",
																textAlign: TextAlign.center,
																style: TextStyle(
																	decoration: TextDecoration.underline,
																	fontSize: _fontSize,
																	color: StrydeColors.darkBlue,
																),
															),
														),
														_teachingAdvisingIcon,
													]
												),
												Container(
													alignment: Alignment.center,
													child: Text(
														"Dennis Gibson & Tom Merrick",
														style: TextStyle(
															fontSize: _fontSize,
															color: StrydeColors.darkGray,
														),
													),
												),
											],
										),
									),
									//Flexible(flex: 1, child: EmptyWidget()),
								]
							),
						),
						Expanded(
							flex: 2,
							child: Container(
								alignment: Alignment.bottomCenter,
								padding: EdgeInsets.only(bottom: 45),
								child: Column(
									mainAxisAlignment: MainAxisAlignment.end,
									children: [
										Image.asset(
											"assets/images/msjLogo.png",
											//scale: 2,
											scale: 3.5,
										),
										Padding(
											padding: EdgeInsets.only(top: 10),
											child: Text(
												"Mount St. Joseph University\n" + "Senior Research Project",
												style: TextStyle(
													fontSize: _fontSize / 1.35,
													color: StrydeColors.darkGray,
												),
												textAlign: TextAlign.center,
											),
										),
									],
								),
							),
						)
					],
				)
			),

			/*
			body: Stack(
				children: [
					Container(
						alignment: Alignment.bottomCenter,
						padding: EdgeInsets.only(bottom: 45),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.end,
							children: [
								Image.asset(
									"assets/images/msjLogo.png",
									scale: 2,
								),
								Padding(
									padding: EdgeInsets.only(top: 10),
									child: Text(
										"Mount St. Joseph University\n" + "Senior Research Project",
										style: TextStyle(
											fontSize: _fontSize / 1.35,
											color: StrydeColors.darkGray,
										),
										textAlign: TextAlign.center,
									),
								),
							],
						),
					),
					
					SafeArea(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								Padding(padding: EdgeInsets.only(top: 275)),
								getDefaultPadding(),
		
								Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										_programmingDesignIcon,
										Padding(
											padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
											child: Text(
												"Programming & Design",
												style: TextStyle(
													decoration: TextDecoration.underline,
													fontSize: _fontSize,
													color: StrydeColors.darkBlue,
												),
											),
										),
										_programmingDesignIcon,
									]
								),
								Container(
									alignment: Alignment.center,
									child: Text(
										"Chris Bean",
										style: TextStyle(
											fontSize: _fontSize,
											color: StrydeColors.darkGray,
										),
									),
								),
								Padding(padding: EdgeInsets.only(top: _topPaddingSize)),
		
								Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										_uiBrandingConsultationIcon,
										Padding(
											padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
											child: Text(
												"UI & Branding Consultation",
												style: TextStyle(
													decoration: TextDecoration.underline,
													fontSize: _fontSize,
													color: StrydeColors.darkBlue,
												),
											),
										),
										_uiBrandingConsultationIcon,
									]
								),
								Container(
									alignment: Alignment.center,
									child: Text(
										"Sara Bustamante",
										style: TextStyle(
											fontSize: _fontSize,
											color: StrydeColors.darkGray,
										),
									),
								),
								Padding(padding: EdgeInsets.only(top: _topPaddingSize)),
		
								Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										_teachingAdvisingIcon,
										Padding(
											padding: EdgeInsets.only(left: _iconPadding, right: _iconPadding),
											child: Text(
												"Early Access Teaching & Advising",
												style: TextStyle(
													decoration: TextDecoration.underline,
													fontSize: _fontSize,
													color: StrydeColors.darkBlue,
												),
											),
										),
										_teachingAdvisingIcon,
									]
								),
								Container(
									alignment: Alignment.center,
									child: Text(
										"Dennis Gibson & Tom Merrick",
										style: TextStyle(
											fontSize: _fontSize,
											color: StrydeColors.darkGray,
										),
									),
								),
							],
						),
					),
				],
			),
			*/
		);
  }
}