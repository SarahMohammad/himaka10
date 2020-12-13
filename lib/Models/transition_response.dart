class TransitionResponse{
  bool status;
  List<String> errors;
  String msg;

  TransitionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['errors'] != null) {
      errors = new List<String>();
      json['errors'].forEach((v) {
        errors.add(v);
      });
    }
  }
}