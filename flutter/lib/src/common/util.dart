//숫자 3자리마다 comma(,) 처리
String commaConvert(dynamic value) {
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  return value.replaceAllMapped(reg, mathFunc);
}
