class EditSize{
  String name;
  String slug;

  EditSize({required this.name,required this.slug});

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'slug' : slug
    };
  }

}