// Model from this API
// https://SITE.COM/wp-json/wc/v3/products

class Product {
  int? id;
  String? name;
  String? description;
  String? shortDescription;
  String? price;
  String? regularPrice;
  //! خالی نمیشه ایمیج گذاشت دارت بهش گیر میده
  List<WooImage>? images;
  List<Categories>? categories;

  Product({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.price,
    this.regularPrice,
    this.images,
    this.categories,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short_description'];
    price = json['price'];
    regularPrice = json['regular_price'];
    if (json['images'] != null) {
      images = <WooImage>[];
      json['images'].forEach((v) {
        images?.add(WooImage.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }
}

class WooImage {
  String? src;
  WooImage({
    this.src,
  });

  WooImage.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }
}

class Categories {
  num? orderId;
  int? id;
  String? name;

  Categories({
    this.orderId,
    this.id,
    this.name,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}
