import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_hub/models/news_channel_headlines_model.dart';


class NewsRepository {

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi()async{

    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=f6f5a45aab1e4c69bbeac1156e87224e';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

}