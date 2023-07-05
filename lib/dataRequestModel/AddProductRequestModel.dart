class AddProductRequestModel{
  String name;
  String slug;
  String short_description;
  String description;
  String regular_price;
  String sale_price;
  String buying_price;
  String SKU;
  String quantity;
  String? newimage;
  String category_id;
  String size_id;


  AddProductRequestModel({required this.name,required this.slug,required this.short_description,
  required this.description,required this.regular_price,
  required this.sale_price,required this.buying_price,
  required this.SKU,required this.quantity,required this.newimage,required this.category_id,required this.size_id});


  Map<String,dynamic> toJson() {
    return {
      'name' : name,
      'slug' : slug,
      "short_description" : short_description,
      "description" : description,
      "regular_price" : regular_price,
      "sale_price" : sale_price,
      "buying_price" : buying_price,
      "SKU" : SKU,
      "quantity" : quantity,
      "newimage" : newimage,
      "category_id" : category_id,
      "size_id" : size_id
    };
}
}