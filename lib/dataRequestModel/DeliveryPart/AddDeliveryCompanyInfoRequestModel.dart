class AddDeliCompanyInfoRequest{
  final String company_id;
  final String city_id;
  final String township_id;
  final String basic_cost;
  final String waiting_time;

  AddDeliCompanyInfoRequest({required this.company_id,required this.city_id,
  required this.township_id,required this.basic_cost,required this.waiting_time});


  Map<String, dynamic> toJson() {
    return {
      'company_id': company_id,
      'city_id': city_id,
      'township_id': township_id,
      'basic_cost' : basic_cost,
      'waiting_time' : waiting_time
    };
  }

}