
class HaveOrderModel{

  String orderId='';
  String name='';
  String cLatitude='';
  String cLongitude='';
  String phone='';
  String cName='';
  String cPhone='';
  String longitude='';
  String latitude='';
  String price='';
  String size='';
  String type='';
  String hint='';
  String date='';
  String customerId='';
  String city='';
  String state='';
  HaveOrderModel({
    required this.name,
    required this.cLongitude,
    required this.orderId,
    required this.cLatitude,
    required this.cName,
    required this.phone,
    required this.cPhone,
    required this.longitude,
    required this.latitude,
    required this.price,
    required this.size,
    required this.type,
    required this.hint,
    required this.date,
    required this.customerId,
    required this.city,
    required this.state,
  });

  HaveOrderModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    cLongitude=json['cLongitude'];
    cName=json['cName'];
    cLatitude=json['cLatitude'];
    orderId=json['orderId'];
    phone=json['phone'];
    cPhone=json['cPhone'];
    longitude=json['longitude'];
    latitude=json['latitude'];
    price=json['price'];
    size=json['size'];
    type=json['type'];
    hint=json['hint'];
    date=json['date'];
    customerId=json['customerId'];
    city=json['city'];
    state=json['state'];



  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'cLongitude':cLongitude,
      'cName':cName,
      'cLatitude':cLatitude,
      'orderId':orderId,
      'phone':phone,
      'cPhone':cPhone,
      'longitude':longitude,
      'latitude':latitude,
      'price':price,
      'size':size,
      'type':type,
      'hint':hint,
      'date':date,
      'customerId':customerId,
      'city':city,
      'state':state,

    };
  }


}