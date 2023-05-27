import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsi_wawan/api_data.dart';
import 'package:responsi_wawan/base_network.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_wawan/detail_matches.dart';
import 'dart:convert';

import 'package:responsi_wawan/detail_matches_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // Future<List>? listmatches;
  // Map? mapmatches;
  // // final String matches;
  //
  // Future apicallmatches()async{
  //   http.Response response;
  //   response = await http.get(Uri.parse("https://copa22.medeiro.tech/matches"));
  //   if(response.statusCode == 200){
  //     listmatches = json.decode(response.body);
  //     // mapmatches = json.decode(response.body);
  //     // print(listmatches.toString());
  //   }else{
  //     print("error nih");
  //   }
  // }

  @override

  // void initState(){
  //   apicallmatches();
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piala Dunia 2022'),
      ),
      body: buildList()
    );
  }

  Widget buildList(){
    return Container(
      child: FutureBuilder(
        future: ApiData.instance.loadmatches(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  DetailMatchesModel listModel = DetailMatchesModel.fromJson(snapshot.data[index]);
                  return Column(
                    children: [
                      Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>
                                    DetailPage(id : listModel!.id.toString(),)
                            ));
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(listModel.homeTeam!.name!),
                                ),
                                SizedBox(width: 50,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text(listModel.homeTeam!.goals!.toString()),
                                      SizedBox(width: 20,),
                                      Text(" - "),
                                      SizedBox(width: 20,),
                                      Text(listModel.awayTeam!.goals!.toString()),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 50,),
                                Container(
                                  child: Text(listModel.awayTeam!.name!),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
