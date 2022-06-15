class CertificationModel {
  late int _id;
  late String _name;
  late DateTime _obtainedDate;
  late DateTime _outdateDate;

  CertificationModel(this._id, this._name, this._obtainedDate, this._outdateDate);

  int get id => _id;
  String get name => _name;
  DateTime get obtainedDate => _obtainedDate;
  DateTime get outdateDate => _outdateDate;

  set id(int i) {
    _id = id;
  }

  set name(String s) {
    _name = s;
  }

  set obtainedDate(DateTime d) {
    _obtainedDate = d;
  }

  set outdateDate(DateTime d) {
    _outdateDate = d;
  }

  /// CertificationModelをMapに変換する(保存時に使用)
  Map toJson() {
    return {'id': id, 'name': name, 'obtainedDate': obtainedDate.toString(), 'outdateDate': outdateDate.toString()};
  }

  /// MapをCertificationModelに変換する(読込時に使用)
  CertificationModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    obtainedDate = json['obtainedDate'];
    outdateDate = json['outdateDate'];
  }
}
