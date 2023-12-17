class SearchModel{
  bool? status;
  late String? message;
  late SearchDate data;

  SearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'] = null ;
    data =   (json['data'] != null ? SearchDate.fromJson(json['data']) : null)!;
  }
}

class SearchDate{
  int? currentPage;
  late List<SearchDataModel> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  int? nextPageUrl;
  String? path;
  int? perPage;
  int? prevPageUrl;
  int? to;
  int? total;

  SearchDate.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    if(json['data'] != null){
      data = <SearchDataModel>[];
      json['data'].forEach((element){
        data.add(SearchDataModel.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}
class SearchDataModel{
  int? id;
  dynamic price;
  late String? image;
  String? name;
  String? description;
  List<dynamic> images = [];
  bool? inFavorites;
  bool? inCart;

  SearchDataModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}