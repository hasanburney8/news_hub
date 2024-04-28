import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_hub/models/news_channel_headlines_model.dart';
import 'package:news_hub/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height*1;
    final w = MediaQuery.sizeOf(context).width*1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Image.asset('images/category_icon.png',
          height: 30,
          width: 30,
          ),
        ),
        title: Text('News',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: h*0.55,
            width: w,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){

                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                color: Colors.amber,
                                height: h*0.6,
                                width: w*0.6,
                                padding: EdgeInsets.symmetric(
                                  horizontal: h*0.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(child: spinKit2,),
                                    errorWidget: (context,url ,error) => Icon(Icons.error_outline, color: Colors.red,),
                                  ),
                                ),
                              ),
                              Positioned(
                                // bottom: 20,
                                child: Card(
                                  color: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.bottomCenter,
                                    height: h*0.22,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: w*0.7,
                                          child: Text(snapshot.data!.articles![index].title.toString(), style: TextStyle(fontSize: 17),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis
                                            ,),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: w*0.7,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(), style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis
                                                ,),
                                              Text(format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)
                                                ,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      )
    );
  }



}


const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);