class Task {
  int? id;
  String? title;
  String? des;
  bool? isCompleted;

  Task({this.id,this.title,this.des,this.isCompleted});

  Task.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    des = json['des'];
    isCompleted = json['isCompleted'] == 0?true:false;
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['des'] = des;
    data['isCompleted'] = isCompleted ;

    return data;
  }
}