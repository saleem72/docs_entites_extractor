//

double? maybeDouble(dynamic value) {
  return (value is num) ? value.toDouble() : null;
}

int? maybeInt(dynamic value) => (value is num) ? value.toInt() : null;

extension EnumDescribe on Object {
  String get describeEnum => toString().split('.').last;
}
