//import 'package:universal_io/io.dart';
//import 'package:url_launcher/url_launcher.dart';

class UrlService {
  /*
  static void openUrl(String url)
  {
    if (!url.contains("http://") || !url.contains("https://"))
    {
      url = "https://" + url;
    }

    launch(url);
  }

  static void call({
    int? countryNumber,
    required int areaCode,
    required int middleThreeDigits,
    required int finalFourDigits,
  })
  {
    String phoneNumber = _parsePhoneNumber(
      countryNumber: countryNumber,
      areaCode: areaCode,
      middleThreeDigits: middleThreeDigits,
      finalFourDigits: finalFourDigits
    );

    launch("tel:" + phoneNumber);
  }

  static void text({
    int? countryNumber,
    required int areaCode,
    required int middleThreeDigits,
    required int finalFourDigits,
  })
  {
    String phoneNumber = _parsePhoneNumber(
      countryNumber: countryNumber,
      areaCode: areaCode,
      middleThreeDigits: middleThreeDigits,
      finalFourDigits: finalFourDigits
    );

    launch("sms:" + phoneNumber);
  }

  static void email({
    required String emailAddress,
    String? subject,
    String? body,
  })
  {
    String url = _parseEmail(
      emailAddress: emailAddress,
      subject: subject,
      body: body,
    );

    launch(url);
  }



  static String _parsePhoneNumber({
    int? countryNumber,
    required int areaCode,
    required int middleThreeDigits,
    required int finalFourDigits,
  })
  {
    String phoneNumber = "";

    if (countryNumber != null)
    {
      phoneNumber += countryNumber.toString();
    }

    if (Platform.isAndroid)
    {
      phoneNumber += areaCode.toString() +
                     middleThreeDigits.toString() +
                     finalFourDigits.toString();
    }
    else if (Platform.isIOS)
    {
      if (countryNumber != null)
      {
        phoneNumber += "-";
      }

      phoneNumber += areaCode.toString() + "-" +
                     middleThreeDigits.toString() + "-" +
                     finalFourDigits.toString();
    }

    return phoneNumber;
  }

  static String _parseEmail({
    required String emailAddress,
    String? subject,
    String? body,
  })
  {
    String url = "mailto:" + emailAddress;

    if (subject != null || body != null)
    {
      url += "?";

      if (subject != null && body == null)
      {
        url += "subject=" + subject;
      }
      else if (subject == null && body != null)
      {
        url += "body=" + body;
      }
      else if (subject != null && body != null)
      {
        url += "subject=" + subject + "&body=" + body;
      }
    }

    return url;
  }
   */
}
