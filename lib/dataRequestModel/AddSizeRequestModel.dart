class AddSizeRequestModel{
  String name;
  String slug;

  AddSizeRequestModel(this.name,this.slug);

  Map<String, dynamic> toJson(){
    return {
      'name' : name,
      'slug' : slug
    };
  }
}