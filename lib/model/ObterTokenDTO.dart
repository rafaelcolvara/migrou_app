class ObterToken {
  String connection;
  String cacheControl;
  String date;
  String vary;
  String strictTransportSecurity;
  String authorization;
  String pragma;
  String xXssProtection;
  String server;
  int contentLength;
  String via;
  String xFrameOptions;
  String xContentTypeOptions;
  int expires;

  ObterToken(
      {this.connection,
      this.cacheControl,
      this.date,
      this.vary,
      this.strictTransportSecurity,
      this.authorization,
      this.pragma,
      this.xXssProtection,
      this.server,
      this.contentLength,
      this.via,
      this.xFrameOptions,
      this.xContentTypeOptions,
      this.expires});

  ObterToken.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    cacheControl = json['cache-control'];
    date = json['date'];
    vary = json['vary'];
    strictTransportSecurity = json['strict-transport-security'];
    authorization = json['authorization'];
    pragma = json['pragma'];
    xXssProtection = json['x-xss-protection'];
    server = json['server'];
    contentLength = json['content-length'];
    via = json['via'];
    xFrameOptions = json['x-frame-options'];
    xContentTypeOptions = json['x-content-type-options'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['cache-control'] = this.cacheControl;
    data['date'] = this.date;
    data['vary'] = this.vary;
    data['strict-transport-security'] = this.strictTransportSecurity;
    data['authorization'] = this.authorization;
    data['pragma'] = this.pragma;
    data['x-xss-protection'] = this.xXssProtection;
    data['server'] = this.server;
    data['content-length'] = this.contentLength;
    data['via'] = this.via;
    data['x-frame-options'] = this.xFrameOptions;
    data['x-content-type-options'] = this.xContentTypeOptions;
    data['expires'] = this.expires;
    return data;
  }
}
