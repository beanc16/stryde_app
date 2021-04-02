import 'dart:convert';
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart" as DotEnv;

// Same as: "dart:io" show Platform; But, works in web browsers too
import "package:universal_io/io.dart" show Platform;


class HttpQueryHelper
{
	static String url = "";
  static String query = "";
	static Map<String, String> env;



  static Future<void> get(String route,
													{Function() onBeforeQuery,
													 Function(dynamic) onSuccess,
													 Function(dynamic) onFailure,}) async
	{
		try
		{
			await _tryInitializeUrls();

			Uri httpUri = Uri.http(url, route);

			if (onBeforeQuery != null)
			{
				onBeforeQuery();
			}

			http.get(httpUri)
				.then((http.Response response)
				{
					if (onSuccess != null)
					{
						onSuccess.call( jsonDecode(response.body) );
					}
				})
				.catchError((err)
				{
					if (onFailure != null)
					{
						onFailure(err);
					}
				});
		}

		catch (err)
		{
			if (onFailure != null)
			{
				onFailure(err);
			}
		}
  }

  static Future<void> post(String route, body,
													 {Function() onBeforeQuery,
														Function(dynamic) onSuccess,
														Function(dynamic) onFailure,})
  async
	{
    try
		{
			await _tryInitializeUrls();

			Uri httpUri = Uri.http(url, route);

			if (onBeforeQuery != null)
			{
				onBeforeQuery();
			}

			http.post(httpUri, body: body)
				.then((http.Response response)
				{
					if (onSuccess != null)
					{
						onSuccess.call( jsonDecode(response.body) );
					}
				})
				.catchError((err)
				{
					if (onFailure != null)
					{
						onFailure(err);
					}
				});
		}

		catch (err)
		{
			if (onFailure != null)
			{
				onFailure(err);
			}
		}
  }
  
  
  
  static Future _tryInitializeUrls() async
	{
		// Don't run the rest of the function if everything is initialized
		if (_envIsInitialized() && _urlIsInitialized())
		{
			return;
		}

		// Load .env variables
		await DotEnv.load(mergeWith: Platform.environment);
		env = DotEnv.env;

		// Log warnings if environment variables aren't set up
		bool canSet = true;
		if (env["SERVER_IP"] == null)
		{
			print("\nWARNING: env.SERVER_IP not set!\n");
			canSet = false;
		}
		if (env["STRYDE_SERVER_PORT"] == null)
		{
			print("\nWARNING: env.STRYDE_SERVER_PORT not set!\n");
			canSet = false;
		}

		// Update url
		if (canSet)
		{
			url = env["SERVER_IP"] + env["STRYDE_SERVER_PORT"];
		}
		else
		{
			url = null;
		}
	}


	
	static bool _urlIsInitialized()
	{
		return (url != null || url.length != 0);
	}

	static bool _envIsInitialized()
	{
		return (env != null);
	}
}
