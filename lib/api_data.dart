import 'base_network.dart';

class ApiData{
  static ApiData instance = ApiData();

  Future<List<dynamic>> loadmatches(){
    return BaseNetwork.getList("matches");
  }

  Future<List<dynamic>> loadmatchesdetail( int idd){
    String id = idd.toString();
    return BaseNetwork.getList("matches/$id");
  }

}