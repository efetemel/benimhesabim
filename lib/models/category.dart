class Category {
  int? id;
  String? name;
  int? addDate;

  Category(
      {this.id,
        this.name,
        this.addDate});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addDate = json['addDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['addDate'] = this.addDate;
    return data;
  }
}