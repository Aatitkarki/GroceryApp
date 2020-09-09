class Photo{
  final String photoName;

  Photo({this.photoName});
  
  factory Photo.fromJson(Map<String,dynamic>parsedJson){
    return Photo(photoName:parsedJson["name"]);
  }
}