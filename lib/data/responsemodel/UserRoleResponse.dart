class UserRoleResponse{
  late int currentPage;
  late List<UserData> data;
  late String? firstPageUrl;
  late int from;
  late int lastPage;
  late String? lastPageUrl;
  late List<Link> links;
  late String? nextPageUrl;
  late String path;
  late int perPage;
  late String? prevPageUrl;
  late int to;
  late int total;

  UserRoleResponse.fromJson(Map<String, dynamic> json) {
  currentPage = json['current_page'];
  data = List<UserData>.from(json['data'].map((data) => UserData.fromJson(data)));
  firstPageUrl = json['first_page_url'];
  from = json['from'];
  lastPage = json['last_page'];
  lastPageUrl = json['last_page_url'];
  links = List<Link>.from(json['links'].map((link) => Link.fromJson(link)));
  nextPageUrl = json['next_page_url'];
  path = json['path'];
  perPage = json['per_page'];
  prevPageUrl = json['prev_page_url'];
  to = json['to'];
  total = json['total'];
  }
  }

  class UserData {
  late int id;
  late String name;
  late String email;
  late DateTime? emailVerifiedAt;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String utype;
  late String? image;
  late String? url;
  late String profilePhotoUrl;

  UserData.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  email = json['email'];
  emailVerifiedAt = json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null;
  createdAt = DateTime.parse(json['created_at']);
  updatedAt = DateTime.parse(json['updated_at']);
  utype = json['utype'];
  image = json['image'];
  url = json['url'];
  profilePhotoUrl = json['profile_photo_url'];
  }
  }

  class Link {
  late String? url;
  late String label;
  late bool active;

  Link.fromJson(Map<String, dynamic> json) {
  url = json['url'];
  label = json['label'];
  active = json['active'];
  }
  }

