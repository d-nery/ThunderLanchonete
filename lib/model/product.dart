class Product {
  final String id;
  final String name;
  final String imageKey;
  final int price;

  const Product({
    this.id,
    this.name,
    this.imageKey,
    this.price,
  });

  Product.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          name: data['name'],
          imageKey: data['imageKey'],
          price: data['price'],
        );
}
