class Product {
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
  String? id;

  Product({
   this.id,
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
});
}