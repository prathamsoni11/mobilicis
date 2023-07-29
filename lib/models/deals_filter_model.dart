class DealsFilterModel {
  Map<String, List<String>> filtersMap = {};
  String? message;

  DealsFilterModel.fromJson(Map<String, dynamic> json) {
    var filtersJson = json['filters'];
    if (filtersJson != null) {
      for (var element in filtersJson.keys.toList()) {
        filtersMap[element] = ["All"] + filtersJson[element].cast<String>();
      }
    }
    message = json['message'];
  }
}
