// class DealsNearYouModel {
//   List<Listings>? listings;
//   String? nextPage;
//   String? message;
//
//   // DealsNearYouModel.fromJson(Map<String, dynamic> json) {
//   //   if (json['listings'] != null) {
//   //     listings = <Listings>[];
//   //     json['listings'].forEach((v) {
//   //       listings!.add(Listings.fromJson(v));
//   //     });
//   //   }
//   //   nextPage = json['nextPage'];
//   //   message = json['message'];
//   // }
//
//   static final DealsNearYouModel _dealsNearYouModel =
//       DealsNearYouModel.internal();
//
//   DealsNearYouModel.internal();
//
//   factory DealsNearYouModel() {
//     return _dealsNearYouModel;
//   }
// }

class DealsModel {
  List<Listings>? listings;
  String? nextPage;
  String? message;

  // Singleton instance
  static final DealsModel _instance = DealsModel._internal();

  // Named constructor
  DealsModel._internal();

  // Factory constructor
  factory DealsModel() {
    return _instance;
  }

  factory DealsModel.fromJson(Map<String, dynamic> json) {
    if (json['listings'] != null) {
      _instance.listings = _instance.listings ?? <Listings>[];
      json['listings'].forEach((v) {
        _instance.listings!.add(Listings.fromJson(v));
      });
    }
    _instance.nextPage = json['nextPage'];
    _instance.message = json['message'];

    return DealsModel();
  }
}

class Listings {
  String? sId;
  String? deviceCondition;
  String? listedBy;
  String? deviceStorage;
  List<Images>? images;
  Images? defaultImage;
  String? listingLocation;
  String? make;
  String? marketingName;
  String? mobileNumber;
  String? model;
  bool? verified;
  String? status;
  String? listingDate;
  String? deviceRam;
  String? createdAt;
  String? listingId;
  int? listingNumPrice;
  String? listingState;

  Listings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    deviceCondition = json['deviceCondition'];
    listedBy = json['listedBy'];
    deviceStorage = json['deviceStorage'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    defaultImage = json['defaultImage'] != null
        ? Images.fromJson(json['defaultImage'])
        : null;
    listingLocation = json['listingLocation'];
    make = json['make'];
    marketingName = json['marketingName'];
    mobileNumber = json['mobileNumber'];
    model = json['model'];
    verified = json['verified'];
    status = json['status'];
    listingDate = json['listingDate'];
    deviceRam = json['deviceRam'];
    createdAt = json['createdAt'];
    listingId = json['listingId'];
    listingNumPrice = json['listingNumPrice'];
    listingState = json['listingState'];
  }
}

class Images {
  String? fullImage;

  Images.fromJson(Map<String, dynamic> json) {
    fullImage = json['fullImage'];
  }
}
