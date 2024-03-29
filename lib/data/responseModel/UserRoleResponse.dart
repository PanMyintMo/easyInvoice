class UserRoleResponse {
  final int currentPage;
  final List<UserData> data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;
  final int? status;
  final String? message;

  UserRoleResponse({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.status,
    required this.message,
  });

  factory UserRoleResponse.fromJson(Map<String, dynamic> json) {
    return UserRoleResponse(
      currentPage: json['data']['current_page'],
      data: (json['data']['data'] as List<dynamic>?)
          ?.map((item) => UserData.fromJson(item))
          .toList() ?? [],
      firstPageUrl: json['data']['first_page_url'],
      from: json['data']['from'],
      lastPage: json['data']['last_page'],
      lastPageUrl: json['data']['last_page_url'],
      links: (json['data']['links'] as List<dynamic>?)
          ?.map((item) => PageLink.fromJson(item))
          .toList() ?? [],
      nextPageUrl: json['data']['next_page_url'],
      path: json['data']['path'],
      perPage: json['data']['per_page'],
      prevPageUrl: json['data']['prev_page_url'],
      to: json['data']['to'],
      total: json['data']['total'],
      status: json['status'],
      message: json['message'],
    );
  }
}

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

class UserData {

  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String utype;
  String? image;
  String? url;
  String profilePhotoUrl;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.utype,
    required this.image,
    required this.url,
    required this.profilePhotoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'] != null
            ? json['email_verified_at']
            : null,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        utype: json['utype'],
        image: json['image'],
        url: json['url'],
        profilePhotoUrl: json['profile_photo_url']);
  }

}