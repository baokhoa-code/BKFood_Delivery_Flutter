class ResponseModel {
  bool _isSucced;
  String _message;

  ResponseModel(this._isSucced, this._message);

  String get message => _message;
  bool get isSucced => _isSucced;
}
