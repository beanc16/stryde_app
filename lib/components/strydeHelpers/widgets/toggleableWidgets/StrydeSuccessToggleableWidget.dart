import 'package:Stryde/components/strydeHelpers/widgets/text/StrydeSuccessText.dart';
import 'package:Stryde/components/toggleableWidget/ToggleableWidget.dart';
import 'package:Stryde/utilities/UiHelpers.dart';
import 'package:flutter/cupertino.dart';
import '../StrydeProgressIndicator.dart';


class StrydeSuccessToggleableWidget extends ToggleableWidget
{
  StrydeSuccessToggleableWidget({
    required String successMsg,
    bool hideOnStartup = true,
    bool showLoadingIndicatorOnLoading = false,
  }) :
    super(
      hideOnStartup: hideOnStartup,
      showLoadingIndicatorOnLoading: showLoadingIndicatorOnLoading,
      loadingIndicator: Column(
        children: [
          Padding(
            child: StrydeProgressIndicator(),
            padding: EdgeInsets.only(left: 5),
          ),
          getDefaultPadding(),
        ],
      ),
      child: Column(
        children: [
          StrydeSuccessText(displayText: successMsg),
          getDefaultPadding(),
        ],
      )
    );
}