class Expense {
  int? id;
  int? typeId;
  String? name;
  String? description;
  double? quantity;
  int? addDate;

  Expense(
      {this.id,
        this.typeId,
        this.name,
        this.description,
        this.quantity,
        this.addDate});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['typeId'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    addDate = json['addDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeId'] = this.typeId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['addDate'] = this.addDate;
    return data;
  }
}