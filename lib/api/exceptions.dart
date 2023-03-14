class UnknownServerError implements Exception {
  int statusCode;
  UnknownServerError(this.statusCode);
  @override
  String toString() {
    return "<Unknown Server Error: { $statusCode }>";
  }
}

class KnownServerError implements Exception {
  int statusCode;
  String cause;
  KnownServerError(this.statusCode, this.cause);
}
