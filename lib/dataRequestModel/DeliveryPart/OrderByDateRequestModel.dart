class OrderByDateRequest{
  final String start_date;
  final String end_date;
  OrderByDateRequest( {required this.start_date, required this.end_date});

  Map<String,dynamic> toJson(){
    return {'start_date': start_date,
    'end_date' : end_date};
  }
}