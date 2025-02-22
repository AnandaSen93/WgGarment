import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson()); 

class HomeModel {
  String? responseText;
  int? responseCode;
  ResponseData? responseData;

  HomeModel({this.responseText, this.responseCode, this.responseData});

  HomeModel.fromJson(Map<String, dynamic> json) {
    responseText = json['responseText'];
    responseCode = json['responseCode'];
    responseData = json['responseData'] != null
        ? new ResponseData.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseText'] = this.responseText;
    data['responseCode'] = this.responseCode;
    if (this.responseData != null) {
      data['responseData'] = this.responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  List<BannerClass>? slidingBanner;
  List<BannerClass>? normalBanner;
  List<Category>? category;
  List<Product>? newArrival;
  List<Product>? mostWanted;
  List<Product>? backInStock;

  ResponseData(
      {this.slidingBanner,
      this.normalBanner,
      this.category,
      this.newArrival,
      this.mostWanted,
      this.backInStock});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['slidingBanner'] != null) {
      slidingBanner = <BannerClass>[];
      json['slidingBanner'].forEach((v) {
        slidingBanner!.add(new BannerClass.fromJson(v));
      });
    }
    if (json['normalBanner'] != null) {
      normalBanner = <BannerClass>[];
      json['normalBanner'].forEach((v) {
        normalBanner!.add(new BannerClass.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['newArrival'] != null) {
      newArrival = <Product>[];
      json['newArrival'].forEach((v) {
        newArrival!.add(new Product.fromJson(v));
      });
    }
    if (json['mostWanted'] != null) {
      mostWanted = <Product>[];
      json['mostWanted'].forEach((v) {
        mostWanted!.add(new Product.fromJson(v));
      });
    }
    if (json['backInStock'] != null) {
      backInStock = <Product>[];
      json['backInStock'].forEach((v) {
        backInStock!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slidingBanner != null) {
      data['slidingBanner'] =
          this.slidingBanner!.map((v) => v.toJson()).toList();
    }
    if (this.normalBanner != null) {
      data['normalBanner'] = this.normalBanner!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.newArrival != null) {
      data['newArrival'] = this.newArrival!.map((v) => v.toJson()).toList();
    }
    if (this.mostWanted != null) {
      data['mostWanted'] = this.mostWanted!.map((v) => v.toJson()).toList();
    }
    if (this.backInStock != null) {
      data['backInStock'] = this.backInStock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerClass {
  String? id;
  String? image;

  BannerClass({this.id, this.image});

  BannerClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

class Category {
  String? categoryId;
  String? categoryImage;
  String? categoryName;
  List<SubCategory>? subCategory;

  Category(
      {this.categoryId,
      this.categoryImage,
      this.categoryName,
      this.subCategory});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryImage = json['categoryImage'];
    categoryName = json['categoryName'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryImage'] = this.categoryImage;
    data['categoryName'] = this.categoryName;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String? subcategoryId;
  String? subcategoryImage;
  String? subcategoryName;

  SubCategory(
      {this.subcategoryId, this.subcategoryImage, this.subcategoryName});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['subcategoryId'];
    subcategoryImage = json['subcategoryImage'];
    subcategoryName = json['subcategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryImage'] = this.subcategoryImage;
    data['subcategoryName'] = this.subcategoryName;
    return data;
  }
}

class Product {
  String? productId;
  String? isWishlist;
  String? productImage;
  String? productOffPercentage;
  String? productShortDescription;
  String? productName;
  String? productOriginalPrice;
  String? productSellPrice;
  List<ColorList>? colorList;
  List<SizeList>? sizeList;

  Product(
      {this.productId,
      this.isWishlist,
      this.productImage,
      this.productOffPercentage,
      this.productShortDescription,
      this.productName,
      this.productOriginalPrice,
      this.productSellPrice,
      this.colorList,
      this.sizeList});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    isWishlist = json['isWishlist'];
    productImage = json['productImage'];
    productOffPercentage = json['productOffPercentage'];
    productShortDescription = json['productShortDescription'];
    productName = json['productName'];
    productOriginalPrice = json['productOriginalPrice'];
    productSellPrice = json['productSellPrice'];
    if (json['colorList'] != null) {
      colorList = <ColorList>[];
      json['colorList'].forEach((v) {
        colorList!.add(new ColorList.fromJson(v));
      });
    }
    if (json['sizeList'] != null) {
      sizeList = <SizeList>[];
      json['sizeList'].forEach((v) {
        sizeList!.add(new SizeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['isWishlist'] = this.isWishlist;
    data['productImage'] = this.productImage;
    data['productOffPercentage'] = this.productOffPercentage;
    data['productShortDescription'] = this.productShortDescription;
    data['productName'] = this.productName;
    data['productOriginalPrice'] = this.productOriginalPrice;
    data['productSellPrice'] = this.productSellPrice;
    if (this.colorList != null) {
      data['colorList'] = this.colorList!.map((v) => v.toJson()).toList();
    }
    if (this.sizeList != null) {
      data['sizeList'] = this.sizeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorList {
  String? code;
  String? name;
  String? valueId;
  String? priceAddOn;

  ColorList({this.code, this.name, this.valueId, this.priceAddOn});

  ColorList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    valueId = json['valueId'];
    priceAddOn = json['priceAddOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['valueId'] = this.valueId;
    data['priceAddOn'] = this.priceAddOn;
    return data;
  }
}

class SizeList {
  String? sizeCode;
  String? sizeId;
  String? priceAddOn;

  SizeList({this.sizeCode, this.sizeId, this.priceAddOn});

  SizeList.fromJson(Map<String, dynamic> json) {
    sizeCode = json['sizeCode'];
    sizeId = json['sizeId'];
    priceAddOn = json['priceAddOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sizeCode'] = this.sizeCode;
    data['sizeId'] = this.sizeId;
    data['priceAddOn'] = this.priceAddOn;
    return data;
  }
}
