
import 'dart:convert';

// Domains domainsFromJson(String str) => Domains.fromJson(json.decode(str));
     List<Domains> domainsFromJson(String str) {
    final data = json.decode(str);
  return List<Domains>.from(data.map((item) => Domains.fromJson(item)));
  }
String domainsToJson(Domains data) => json.encode(data.toJson());

class Domains {
    String domainId;
    String domainName;
    String domainImageUrl;

    Domains({
        this.domainId,
        this.domainName,
        this.domainImageUrl,
    });

    factory Domains.fromJson(Map<String, dynamic> json) => Domains(
        domainId: json["domain_id"],
        domainName: json["domain_name"],
        domainImageUrl: json["domain_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "domain_id": domainId,
        "domain_name": domainName,
        "domain_image_url": domainImageUrl,
    };
}
