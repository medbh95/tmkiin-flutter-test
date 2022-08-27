class Products {
  int? id;
  int? userId;
  String? name;
  String? sku;
  int? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id,
      this.userId,
      this.name,
      this.sku,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    sku = json['sku'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
