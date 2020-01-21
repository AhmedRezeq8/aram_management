
import 'package:aram_management/src/model/domain.dart';
import 'package:aram_management/src/model/video_status.dart';
import 'package:http/http.dart' show Client;

class DomainApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<Domains>> getDomains() async {
    final response = await client.get("$baseUrl/domains/get");
    if (response.statusCode == 200) {
      return domainsFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createDomains(Domains data) async {
    final response = await client.post(
      "$baseUrl/domain/post",
      headers: {"content-type": "application/json"},
      body: domainsToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDomains(Domains data) async {
    final response = await client.put(
      "$baseUrl/domain/put/${data.domainId}",
      headers: {"content-type": "application/json"},
      body: domainsToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDomains(int id) async {
    final response = await client.delete(
      "$baseUrl/domain/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
