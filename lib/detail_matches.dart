import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bismillah_bisa/api_data.dart';
import 'package:bismillah_bisa/detail_matches_model.dart';
import 'package:flutter/rendering.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match ID : " + widget.id),
      ),
      body: buildList(widget.id),
    );
  }

  Widget buildList(String idMatch){
    return Container(
      child: FutureBuilder(
        future: ApiData.instance.loadmatchesdetail(idMatch),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            DetailMatchesModel detailModel = DetailMatchesModel.fromJson(snapshot.data);
            return _buildSuccessSection(detailModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(){
    return Container(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(DetailMatchesModel data){
    return ListView(
      children: [
        Column(
          children: [
            Card(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.network("https://flagcdn.com/256x192/" + data.homeTeam!.country!.substring(0, 2).toLowerCase() + ".png",
                          height: 100, width: 150,fit: BoxFit.fitHeight,),
                        Text(data.homeTeam!.name!),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Container(
                      child: Row(
                          children: [
                            Text(data.homeTeam!.goals!.toString()),
                            SizedBox(width: 20,),
                            Text(" - "),
                            SizedBox(width: 20,),
                            Text(data.awayTeam!.goals!.toString()),
                          ]
                      ),
                    ),
                    SizedBox(width: 50,),
                    Column(
                      children: [
                        Image.network("https://flagcdn.com/256x192/" + data.awayTeam!.country!.substring(0, 2).toLowerCase() + ".png",
                          height: 100, width: 150,fit: BoxFit.fitHeight,),
                        Text(data.awayTeam!.name!)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text("Stadium : " + data.venue!),
                  SizedBox(height: 10,),
                  Text("Location : " + data.location!),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Statistic", style: TextStyle(fontSize: 24),),
                          Text("Ball Possession"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.ballPossession!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.ballPossession!.toString()),),
                            ],
                          ),
                          Text("Shot"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.attemptsOnGoal!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.attemptsOnGoal!.toString()),),
                            ],
                          ),
                          Text("Shot on Goal"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.kicksOnTarget!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.kicksOnTarget!.toString()),),
                            ],
                          ),
                          Text("Corners"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.corners!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.corners!.toString()),),
                            ],
                          ),
                          Text("Offside"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.offsides!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.offsides!.toString()),),
                            ],
                          ),
                          Text("Fouls"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(data.homeTeam!.statistics!.foulsCommited!.toString()),),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(data.awayTeam!.statistics!.foulsCommited!.toString()),),
                            ],
                          ),
                          Text("Pass Accuracy"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text(
                                _accuracypercentage(data.homeTeam!.statistics!.passes!,
                                    data.homeTeam!.statistics!.passesCompleted!) + "%",
                              )),
                              SizedBox(width: 100,),
                              Container(child: Text("-"),),
                              SizedBox(width: 100,),
                              Container(child: Text(
                                _accuracypercentage(data.awayTeam!.statistics!.passes!,
                                    data.awayTeam!.statistics!.passesCompleted!) + "%",
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
                )
              ],
            ),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Referees", style: TextStyle(fontSize: 24),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                for(int i = 0; i<data.officials!.length.toInt();i++)
                  Column(
                  children: [
                  Text(data.officials![i].name.toString()),
                  Text(i.toString())
                  ],
                  )
                // Container(
                //   height: MediaQuery.of(context).size.height/3,
                //   child:_officiallist(data),
                // )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildLoadingSection(){
    return CircularProgressIndicator();
  }

  String _accuracypercentage (int total, int complete){
    int accuracy = ((complete/total) * 100).ceil();
    return (accuracy).toString();
  }

  Widget _officiallist(DetailMatchesModel data){
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.officials!.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              Text(data.officials![index].name.toString()),
              Text(index.toString())
            ],
          );
        });
  }
}
