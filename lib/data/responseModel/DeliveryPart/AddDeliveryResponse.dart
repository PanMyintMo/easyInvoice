class AddDeliveryResponse{
  final String name;
  final String image;
  final String url;
  final String updated_at;
  final String created_at;
  final int id;

  AddDeliveryResponse({required this.name,required this.image,required this.url,
  required this.updated_at,required this.created_at, required this.id});

  factory AddDeliveryResponse.fromJson(Map<String,dynamic> data){
    final dataJson = data['data'] as Map<String, dynamic>;
    
    return AddDeliveryResponse(name: dataJson['name'],image: dataJson['image'],
      url: dataJson['url'],updated_at: dataJson['updated_at'],created_at: dataJson['created_at'], id: dataJson['id']
    );
  }
}