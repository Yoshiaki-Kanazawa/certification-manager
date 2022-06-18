import 'package:intl/intl.dart';

class ApplicationConst {
  // 日付フォーマッター
  final formatter = DateFormat('yyyy-MM-dd');

  // 取得日Label
  final String obtainedDateLabel = 'obtainedDate';

  // 期限Label
  final String outdateDateLabel = 'outdateDate';

  // ソート要素：有効期限が早い順
  final String sortOrderEarliestExpirationDate = '有効期限が早い順';

  // ソート要素：有効期限が早い順
  final String sortOrderCertificationName = '資格名順';

  // ソート要素：有効期限が早い順
  final String sortOrderEarliestObtainedDate = '取得日が早い順';
}
