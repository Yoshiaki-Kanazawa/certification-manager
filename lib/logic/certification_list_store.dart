import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certification_manager/model/certification_model.dart';

// Certification情報の管理クラス
//
// 以下の責務を持つ
// ・Certification情報を追加/更新/削除する
// ・Certification情報を保存/ロードする
class CertificationListStore {
  // 保存時のキー
  final String _saveKey = "Certification";

  // Certificationリスト
  List<CertificationModel> _certificationList = [];

  static final CertificationListStore _instance = CertificationListStore._internal();

  CertificationListStore._internal();

  factory CertificationListStore() {
    return _instance;
  }

  List<CertificationModel> get certificationList => _certificationList;

  // Certificationの件数を取得する
  int count() {
    return _certificationList.length;
  }

  // 指定したインデックスのCertificationを取得する
  CertificationModel findByIndex(int index) {
    return _certificationList[index];
  }

  // Certificationを追加する
  void add(String name, DateTime obtainedDate, DateTime outdateDate) {
    var id = count() == 0 ? 1 : _certificationList.last.id + 1;
    var certification = CertificationModel(id, name, obtainedDate, outdateDate);
    _certificationList.add(certification);

    // デフォルトで有効期限が近い順にでソートする
    _certificationList.sort((a, b) => a.outdateDate.compareTo(b.outdateDate));
    save();
  }

  // Certificationを更新する
  void update(CertificationModel certification, [String? name, DateTime? obtainedDate, DateTime? outdateDate]) {
    if (name != null) {
      certification.name = name;
    }
    if (obtainedDate != null) {
      certification.obtainedDate = obtainedDate;
    }
    if (outdateDate != null) {
      certification.outdateDate = outdateDate;
    }
    save();
  }

  // Certificationを削除する
  void delete(CertificationModel todo) {
    _certificationList.remove(todo);
    save();
  }

  // Certificationを保存する
  void save() async {
    var prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // CertificationList形式 → Map形式 → JSON形式 → StrigList形式
    var saveTargetList = _certificationList.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  // Certificationを読込する
  void load() async {
    var prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // StrigList形式 → JSON形式 → Map形式 → CertificationList形式
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _certificationList = loadTargetList.map((a) => CertificationModel.fromJson(json.decode(a))).toList();
  }
}
