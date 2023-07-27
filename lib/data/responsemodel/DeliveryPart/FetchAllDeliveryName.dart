class FetchAllDeliveryName {
  final List<AllDeliveryName> allDeliveryName;

  FetchAllDeliveryName({required this.allDeliveryName});

  factory FetchAllDeliveryName.fromJson(Map<String, dynamic> json) {
    return FetchAllDeliveryName(
      allDeliveryName: List<AllDeliveryName>.from(
        json['data'].map((allDeliveryName) => AllDeliveryName.fromJson(allDeliveryName)),
      ),
    );
  }
}
class AllDeliveryName {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String? image;
  final String? url;

  AllDeliveryName({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.image,
  });

  factory AllDeliveryName.fromJson(Map<String, dynamic> json) {
    return AllDeliveryName(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
      url: json['url'],
    );
  }
}
