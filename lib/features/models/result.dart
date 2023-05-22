class ResultModel {
  String? image;
  String? result;
  String? typeBody;

  ResultModel(
      {required this.image, required this.result, required this.typeBody});
  ResultModel.fromJson(Map<dynamic, dynamic> map) {
    image = map['image'];
    result = map['result'];
    typeBody = map['typeBody'];
  }
  toJson() {
    return {
      'image': image,
      'result': result,
      'typeBody': typeBody,
    };
  }
}
