// Certification入力画面のクラス
//
// 以下の責務を持つ
// ・Certification入力画面の状態を生成する
import 'package:certification_manager/logic/certification_list_store.dart';
import 'package:certification_manager/model/certification_model.dart';
import 'package:certification_manager/page/common/header.dart';
import 'package:certification_manager/util/application_const.dart';
import 'package:flutter/material.dart';

import '../../util/disable_focus_node.dart';

class CertificationInputPage extends StatefulWidget {
  // certificationのモデル
  final CertificationModel? certification;

  // コンストラクタ
  // Certificationを引数で受け取った場合は更新、受け取らない場合は追加画面となる
  const CertificationInputPage({Key? key, this.certification}) : super(key: key);

  /// Certification入力画面の状態を生成する
  @override
  State<CertificationInputPage> createState() => _CertificationInputPageState();
}

// Certification入力画面の状態クラス
//
// 以下の責務を持つ
// ・Certificationを追加/更新する
// ・Certificationリスト画面へ戻る
class _CertificationInputPageState extends State<CertificationInputPage> {
  // ストア
  final CertificationListStore _store = CertificationListStore();

  // 新規追加を示すかどうかのフラグ
  late bool _isCreateCertification;

  // 画面項目：資格名
  late String _name;

  // 画面項目：取得日
  late DateTime _obtainedDate;

  // 画面項目：期限
  late DateTime _outdateDate;

  // 取得日入力初期値
  DateTime selectedObtainedDate = DateTime.now();

  // 期限入力初期値
  DateTime selectedOutdateDate = DateTime.now();

  // 初期処理を行う
  @override
  void initState() {
    super.initState();
    var certification = widget.certification;

    _name = certification?.name ?? "";
    _obtainedDate = certification?.obtainedDate ?? DateTime.now();
    _outdateDate = certification?.outdateDate ?? DateTime.now();
    _isCreateCertification = certification == null;
  }

  // 画面を作成する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isCreateCertification ? '資格情報追加' : '資格情報更新')),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            // 資格名のテキストフィールド
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "資格名",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: _name),
              onChanged: (String value) {
                _name = value;
              },
            ),
            const SizedBox(height: 20),
            // 取得日のテキストフィールド
            TextField(
              focusNode: AlwaysDisabledFocusNode(),
              decoration: const InputDecoration(
                labelText: "取得日",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: ApplicationConst().formatter.format(_obtainedDate)),
              onTap: () => _selectDate(context, ApplicationConst().obtainedDateLabel),
            ),
            const SizedBox(height: 20),
            // 取得日のテキストフィールド
            TextField(
              focusNode: AlwaysDisabledFocusNode(),
              decoration: const InputDecoration(
                labelText: "期限",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              controller: TextEditingController(text: ApplicationConst().formatter.format(_outdateDate)),
              onTap: () => _selectDate(context, ApplicationConst().outdateDateLabel),
            ),
            const SizedBox(height: 20),
            // 追加/更新ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreateCertification) {
                    _store.add(_name, _obtainedDate, _outdateDate);
                  } else {
                    _store.update(widget.certification!, _name, _obtainedDate, _outdateDate);
                  }
                  // Certificationリスト画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateCertification ? '追加' : '更新',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // キャンセルボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Certificationリスト画面に戻る
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                child: const Text(
                  "キャンセル",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context, String label) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2100, 1),
    );

    if (label == ApplicationConst().obtainedDateLabel) {
      if (picked != null && picked != selectedObtainedDate) {
        setState(() {
          selectedObtainedDate = picked;
          _obtainedDate = DateTime(selectedObtainedDate.year, selectedObtainedDate.month, selectedObtainedDate.day);
        });
      }
    } else if (label == ApplicationConst().outdateDateLabel) {
      if (picked != null && picked != selectedOutdateDate) {
        setState(() {
          selectedOutdateDate = picked;
          _outdateDate = DateTime(selectedOutdateDate.year, selectedOutdateDate.month, selectedOutdateDate.day);
        });
      }
    }
  }
}
