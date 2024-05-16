
class ShopModel{

   String uId='';
   String name='';
   String rate='';
   String image='';
   String city='';
   String Latitude='';
   String Longitude='';

   ShopModel({
     required this.name,
     required this.rate,
     required this.uId,
     required this.city,
     required this.image,

     required this.Latitude,
     required this.Longitude,


});

   ShopModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     rate=json['rate'];
     city=json['city'];
     uId=json['uId'];
     image=json['image'];
     Latitude=json['Latitude'];
     Longitude=json['Longitude'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'rate':rate,
       'city':city,
       'uId':uId,
       'image':image,
       'Latitude':Latitude,
       'Longitude':Longitude,




     };
   }


}