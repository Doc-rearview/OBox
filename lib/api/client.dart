import 'package:appwrite/appwrite.dart';
class ApiClient{
  Client get _client{
    Client client=Client();

    client
      .setEndpoint('http://localhost:8080/v1')
      .setProject('69073b86000e27eb6165')
      .setSelfSigned(status: true);
    return client;
  }
  static Account get account => Account(_instance._client);
  static Databases get database => Databases(_instance._client);
  static Storage get storage => Storage(_instance._client);

  static final ApiClient _instance = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instance;

}