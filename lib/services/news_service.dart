import 'package:tarjuman_e_sindh_admin/models/news_model.dart';
import 'package:tarjuman_e_sindh_admin/models/weekly_graph_model.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import '../models/response_model.dart';
import '../utils/firebase_client.dart';

class NewsServices{

  Future<List<NewsModel>> getAllNews()async{
    List<NewsModel> news = [];
    var data = await FirebaseClient().firebaseGetRequest(collectionName: kNewsCollection);
    if(data is List){
      for(var i in data){
        news.add(NewsModel.fromJson(i));
      }
    }
    else{
      news = [];
    }
    return news;
  }

  Future<String> addNews(NewsModel newsModel) async {
    List<NewsModel> hospitals = await getAllNews();
    int id = 0;
    if (hospitals.isNotEmpty) {
      id = hospitals.map((hospital) => hospital.id).reduce((value, element) => value > element ? value : element);
    }
    newsModel.id=id+1;
    ResponseModel responseModel = await FirebaseClient().firebaseInsertRequest(model: newsModel, collectionName: kNewsCollection, id: newsModel.id.toString());
    return responseModel.statusDescription;
  }

  Future<String> updateNews(NewsModel newsModel)async{
    ResponseModel responseModel = await FirebaseClient().firebaseUpdateRequest(model: newsModel, collectionName: kNewsCollection, id: newsModel.id.toString());
    return responseModel.statusDescription;
  }

  Future<String> deleteNews({required String id})async{
    ResponseModel responseModel = await FirebaseClient().firebaseDeleteRequest(collectionName: kNewsCollection, id: id);
    return responseModel.statusDescription;
  }
  Future<List<WeeklyGraphModel>> getCounts()async{
    List<WeeklyGraphModel> data = await FirebaseClient().firebaseGetWeeklyGraphData(collectionName: kNewsCollection);
    return data;
  }

}