class Cafe {
  int? id;
  String? title;
  String? content;
  String? alamat;
  String? link;
  String? image;

  int? get getId => this.id;

  set setId(int? id) => this.id = id;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getAlamat => this.alamat;

  set setAlamat(alamat) => this.alamat = alamat;

  get getLink => this.link;

  set setLink(link) => this.link = link;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  Cafe({this.id, this.title, this.content, this.alamat, this.link, this.image});

  Cafe.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.content = parsedJson['content'];
    this.alamat = parsedJson['alamat'];
    this.link = parsedJson['link'];
    this.image = parsedJson['image'];
  }
}
