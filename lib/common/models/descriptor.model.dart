class DescriptorModel {
  final String title;
  final String description;

  DescriptorModel({this.title, this.description});

  factory DescriptorModel.fromJson(Map<String, dynamic> json) {
    return DescriptorModel(
        title: json['title'], description: json['description']);
  }
}
