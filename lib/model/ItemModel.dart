
class ItemModel{

  String publisherId='';
  String name='';
  String image='';
  String price='';
  String desc='';


  ItemModel({
    required this.name,
    required this.publisherId,
    required this.desc,
    required this.price,
    required this.image,



  });

  ItemModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    price=json['price'];
    publisherId=json['publisherId'];
    image=json['image'];
    desc=json['desc'];




  }
  Map<String,dynamic> Tomap(){
    return{
      'name':name,
      'price':price,
      'publisherId':publisherId,
      'image':image,
      'desc':desc,




    };
  }


}