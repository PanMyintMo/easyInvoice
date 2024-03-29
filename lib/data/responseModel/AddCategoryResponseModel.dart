
class AddCategoryResponse{
  String name;
  String slug;
  String updated_at;
  String created_at;
  int id;
  int status;
  String message;

  AddCategoryResponse({
    required this.name,required this.slug,required this.updated_at,required this.created_at,required this.id,required this.status, required this.message});


  factory AddCategoryResponse.fromJson(Map<String,dynamic> data) {
    final dataJson=data['data'] as Map<String,dynamic>;

    return AddCategoryResponse(name: dataJson['name'],
        slug: dataJson['slug'],
        updated_at: dataJson['updated_at'],
        created_at: dataJson['created_at'],
        id: dataJson['id'],
        status: data['status'],
        message: data['message']);

  }
}
