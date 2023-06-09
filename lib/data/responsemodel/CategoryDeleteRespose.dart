class DeleteCategory{
  int status;
  String message;
  DeleteCategory({required this.status,required this.message});

  factory DeleteCategory.fromJson(Map<String, dynamic> json){
    return DeleteCategory(status: json['status'], message: json['message']);
  }
}