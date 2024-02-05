class ContactModel {
  String? name;
  String? number;
  String? id;

  ContactModel({this.name, this.number,this.id});

  ContactModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    number = json["number"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["number"] = number;
    data["id"] = id;
    return data;
  }
}