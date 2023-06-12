class EditCategory{
  String name;
  String slug;

  EditCategory({required this.name,required this.slug});

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'slug' : slug
    };
  }

}