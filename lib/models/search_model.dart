class SearchModel {
  List<String>? makes;
  List<String>? models;
  String? message;

  SearchModel.fromJson(Map<String, dynamic> json) {
    makes = json['makes'].cast<String>();
    models = json['models'].cast<String>();
    message = json['message'];
  }
}
