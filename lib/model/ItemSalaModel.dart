
class ItemSalaModel{

  String publisherId='';
  String name='';
  String image='';
  String price='';
  int amount=0;


  ItemSalaModel({
    required this.name,
    required this.amount,
    required this.publisherId,
    required this.price,
    required this.image,



  });

  ItemSalaModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    price=json['price'];
    publisherId=json['publisherId'];
    image=json['image'];
    amount=json['amount'];





  }
  Map<String,dynamic> Tomap(){
    return{
      'name':name,
      'price':price,
      'publisherId':publisherId,
      'image':image,
      'amount':amount,





    };
  }


}