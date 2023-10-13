class NoConnectivityException implements Exception{
  final String message;
  NoConnectivityException(this.message);
  @override
  String toString(){
    return message;
  }
}