class OrderByDateRequest{
  final String start_date;
  OrderByDateRequest({required this.start_date});

  Map<String,dynamic> toJson(){
    return {'start_date': start_date};
  }
}