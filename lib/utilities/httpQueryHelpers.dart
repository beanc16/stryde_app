import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;


class HttpQueryHelper
{
  static String ip = "64.227.12.181";
  static String port = ":8000";
  static String url = "http://" + ip + port;



  static void get(String route, body, {Function() onSuccess, Function() onFailure})
  {
    try
	{
      dynamic response = await http.get(url + route, body: body);
	  
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

  static void post(String route, body, {Function() onSuccess, Function() onFailure})
  {
    try
	{
      dynamic response = await http.post(url + route, body: body);
	  
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
