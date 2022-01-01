class Menu {
  int? id;
  int? cafe_id;
  String? title;
  String? content;
  String? harga;
  String? image;
  int? get getId => this.id;

  set setId(int? id) => this.id = id;

  get cafeid => this.cafe_id;

  set cafeid(value) => this.cafe_id = value;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getHarga => this.harga;

  set setHarga(harga) => this.harga = harga;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  Menu(
      {this.id,
      this.title,
      this.content,
      this.cafe_id,
      this.harga,
      this.image});

  Menu.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.content = parsedJson['content'];
    this.cafe_id = parsedJson['cafe_id'];
    this.harga = parsedJson['harga'];
    this.image = parsedJson['image'];
  }
}
