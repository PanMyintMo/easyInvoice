class AddCategoryRequestModel{
  String name;
  String slug;

  AddCategoryRequestModel(this.name,this.slug);

  Map<String, dynamic> toJson(){
    return {
      'name' : name,
      'slug' : slug
    };
  }
}