class BaseResponse {
    Object data;
    int code;
    String message;

    BaseResponse({this.data, this.code, this.message});

    factory BaseResponse.fromJson(Map<String, dynamic> json) {
        return BaseResponse(
            code: json['code'],
            message: json['message'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['message'] = this.message;
        return data;
    }
}