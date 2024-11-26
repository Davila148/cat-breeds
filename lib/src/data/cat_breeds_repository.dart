import 'package:http/http.dart' as http;


class CatBreedsRepository {
  final String _baseUrl = 'api.thecatapi.com';

  Future<dynamic> getJsonData(String endpoint,
      [Map<String, String>? params]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      ...?params,
    });

    final response = await http.get(url);
    return response;
  }
}