class SendEmailToCheckRequest {
  SendEmailToCheckRequest({
      this.email,});

  SendEmailToCheckRequest.fromJson(dynamic json) {
    email = json['email'];
  }
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

}