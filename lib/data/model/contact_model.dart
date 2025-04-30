const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String emailColumn = "emailColumn";
const String phoneColumn = "phoneColumn";
const String imgColumn = "imgColumn";
const String contactTable = "contactTable";

class ContactModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String img;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.img,
  });

  ContactModel.fromMap(Map map)
    : id = map[idColumn],
      name = map[nameColumn],
      email = map[emailColumn],
      phone = map[phoneColumn],
      img = map[imgColumn];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
    return map;
  }
}
