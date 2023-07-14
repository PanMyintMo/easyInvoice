class UserRoleResponse {
  int currentPage;
  List<UserData> data;
  String? firstPageUrl;
  int from;
  int lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;
  int status;
  String message;

  UserRoleResponse({
    required this.currentPage, required this.data, required this.firstPageUrl, required this.from, required this.lastPage, required this.lastPageUrl,
    required this.links, required this.nextPageUrl, required this.path, required this.perPage, required this.prevPageUrl, required this.to, required this.total,
    required this.status, required this.message
  });


  factory UserRoleResponse.fromJson(Map<String, dynamic> json) {
    final dataList = json['data']['data'] as List<dynamic>;
    final data = dataList.map((userData) => UserData.fromJson(userData))
        .toList();
    return UserRoleResponse(
        currentPage: json['data']['current_page'],
        data: data,
        firstPageUrl: json['data']['first_page_url'],
        from: json['data']['from'],
        lastPage: json['data']['last_page'],
        lastPageUrl: json['data']['last_page_url'],
        links: List<Link>.from(json['data']['links'].map((link) => Link.fromJson(link))),
        nextPageUrl: json['data']['next_page_url'],
        path: json['data']['path'],
        perPage: json['data']['per_page'],
        prevPageUrl: json['data']['prev_page_url'],
        to: json['data']['to'],
        total: json['data']['total'],
        status: json['status'],
        message: json['message']);
  }
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
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

  factory UserData.fromJson(Map<String,dynamic> json){
    return UserData(id: json['id'], name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at']!=null ? json['email_verified_at'] : null,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        utype: json['utype'],
        image: json['image'], url: json['url'],
        profilePhotoUrl: json['profile_photo_url']);
  }
}


