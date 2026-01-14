class PageableProductResponseDto {
  PageableProductResponseDto({
      this.results, 
      this.metadata, 
      this.data,});

  PageableProductResponseDto.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDto.fromJson(v));
      });
    }
  }
  num? results;
  Metadata? metadata;
  List<ProductDto>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductDto {
  ProductDto({
      this.sold, 
      this.images, 
      this.ratingsQuantity,
      this.title,
      this.slug, 
      this.description, 
      this.quantity, 
      this.price, 
      this.priceAfterDiscount, 
      this.imageCover,
      this.ratingsAverage, 
      this.createdAt, 
      this.updatedAt, 
      this.id,});

  ProductDto.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    ratingsQuantity = json['ratingsQuantity'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    imageCover = json['imageCover'];

    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
  num? sold;
  List<String>? images;
  num? ratingsQuantity;
  String? title;
  String? slug;
  String? description;
  num? quantity;
  num? price;
  num? priceAfterDiscount;
  String? imageCover;
  num? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sold'] = sold;
    map['images'] = images;

    map['ratingsQuantity'] = ratingsQuantity;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['quantity'] = quantity;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['imageCover'] = imageCover;
    map['ratingsAverage'] = ratingsAverage;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['id'] = id;
    return map;
  }

}







class Metadata {
  Metadata({
      this.currentPage, 
      this.numberOfPages, 
      this.limit,});

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }
  num? currentPage;
  num? numberOfPages;
  num? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    return map;
  }

}