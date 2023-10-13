import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityService{
  final Connectivity _connectivity = Connectivity();

  Future<ConnectivityResult> checkConnectivity() async{
    try{
      final result= await _connectivity.checkConnectivity();
      return result;
    }
    catch(e){
      return ConnectivityResult.none;
    }
  }


}