import 'base_network.dart';

class ApiData{
  static ApiData instance = ApiData();

  Future<List<dynamic>> loadmatches(){
    return BaseNetwork.getList("matches");
  }

  Future<Map<String, dynamic>> loadmatchesdetail(String rid){
    String id = rid;
    return BaseNetwork.get("matches/$id");
  }

}