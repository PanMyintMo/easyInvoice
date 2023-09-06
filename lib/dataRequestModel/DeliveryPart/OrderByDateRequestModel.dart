class OrderByDateRequest{
  final String date;
  OrderByDateRequest({required this.date});

  Map<String,dynamic> toJson(){
    return {'date': date};
  }
}