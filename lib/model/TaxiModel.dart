
class TaxiModel{

  String publisherId='';
  String name='';
  String locationLatitude='';
  String locationLongitude='';
  String price='';
  String phone='';

  TaxiModel({
    required this.name,
    required this.publisherId,
    required this.phone,
    required this.price,
    required this.locationLatitude,
    required this.locationLongitude,



  });

  TaxiModel.fromjson(Map<String,dynamic>json){
    publisherId=json['publisherId'];
    name=json['name'];
    price=json['price'];
    locationLatitude=json['locationLatitude'];
    locationLongitude=json['locationLongitude'];
    phone=json['phone'];




  }
  Map<String,dynamic> Tomap(){
    return{
      'name':name,
      'price':price,
      'publisherId':publisherId,
      'locationLatitude':locationLatitude,
      'locationLongitude':locationLongitude,
      'phone':phone,




    };
  }


}