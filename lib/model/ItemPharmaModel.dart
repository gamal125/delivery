
class ItemPharmaModel{

  String address='';
  String name='';
  String image='';
  String pharmaName='';
  String hint='';


  ItemPharmaModel({
    required this.name,
    required this.hint,
    required this.address,
    required this.pharmaName,
    required this.image,



  });

  ItemPharmaModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    pharmaName=json['pharmaName'];
    address=json['address'];
    image=json['image'];
    hint=json['amount'];





  }
  Map<String,dynamic> Tomap(){
    return{
      'name':name,
      'pharmaName':pharmaName,
      'address':address,
      'image':image,
      'amount':hint,





    };
  }


}