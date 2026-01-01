class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.statusMsg, 
      this.message,});

  ForgetPasswordResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
    status = json['status'];
    token = json['token'];
  }
  String? statusMsg;
  String? message;
  String? status;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }

}