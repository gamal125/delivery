
class OrderModel{

  String customerId='';
  String totalPrice='';
  String shopName='';
  String date='';
  String state='';
  String city='';
  String Latitude='';
  String Longitude='';
  String shopLatitude='';
  String shopLongitude='';
  String? type;

  OrderModel({
    required this.totalPrice,
    required this.date,
    required this.customerId,
    required this.shopName,
    required this.city,
    required this.state,
    required this.Latitude,
    required this.Longitude,
    required this.shopLatitude,
    required this.shopLongitude,
    required this.type,


  });

  OrderModel.fromjson(Map<String,dynamic>json){
    totalPrice=json['totalPrice'];
    date=json['date'];
    city=json['city'];
    shopName=json['shopName'];
    customerId=json['customerId'];
    state=json['state'];
    type=json['type'];
    Latitude=json['Latitude'];
    Longitude=json['Longitude'];
    shopLatitude=json['shopLatitude'];
    shopLongitude=json['shopLongitude'];



  }
  Map<String,dynamic> Tomap(){
    return{
      'totalPrice':totalPrice,
      'date':date,
      'city':city,
      'shopName':shopName,
      'customerId':customerId,
      'state':state,
      'Latitude':Latitude,
      'Longitude':Longitude,
      'shopLatitude':shopLatitude,
      'shopLongitude':shopLongitude,
      'type':type,


    };
  }


}