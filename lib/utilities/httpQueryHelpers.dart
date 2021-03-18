import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;


class HttpQueryHelper
{
  static String ip = "64.227.12.181";
  static String port = ":8000";
  static String url = "http://" + ip + port;
  static String query = "";



  static Future<void> get(String route, body, {Function(dynamic) onSuccess,
																							 Function(dynamic) onFailure}) async
	{
    try
		{
			Uri httpUri = Uri.http(url + route, query, body);
			//dynamic response = await http.get(httpUri, body: body);
			dynamic response = await http.get(httpUri);

			if (onSuccess != null)
			{
				onSuccess(response);
			}
		}

		catch (err)
		{
			if (onFailure != null)
			{
				onFailure(err);
			}
		}
  }

  static Future<void> post(String route, body, {Function(dynamic) onSuccess,
																				Function(dynamic) onFailure})
  async {
    try
		{
			Uri httpUri = Uri.http(url + route, query, body);
			//dynamic response = await http.post(url + route, body: body);
			//dynamic response = await http.post(httpUri, body: body);
			dynamic response = await http.post(httpUri);

			if (onSuccess != null)
			{
				onSuccess(response);
			}
		}

		catch (err)
		{
			if (onFailure != null)
			{
				onFailure(err);
			}
		}
  }
}
