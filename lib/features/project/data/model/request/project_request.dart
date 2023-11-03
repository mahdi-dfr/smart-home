class ProjectRequest {
  String name;
  String address;

  ProjectRequest(this.name, this.address);

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}