abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}
class UpdateProductSuccessStates extends AppStates {}
class UpdateProductErrorStates extends AppStates {
  final String error;

  UpdateProductErrorStates( this.error);
}
class CreateUserSuccessState extends AppStates {}
class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState( this.error);
}
class GetUserFoodMenuSuccessState extends AppStates{
  final String type;
  final String restaurant;
  final String shopLatitude;
  final  String shopLongitude;
  GetUserFoodMenuSuccessState(this.type,this.restaurant,this.shopLatitude,this.shopLongitude);
}
class GetUserMarketMenuSuccessState extends AppStates{
  final String type;
  final String market;
  GetUserMarketMenuSuccessState(this.type,this.market);
}
class DecSuccessState extends AppStates {}
class IncSuccessState extends AppStates {}
class LogoutLoadingState extends AppStates {}
class LogoutSuccessState extends AppStates {}
class OrderLoadingState extends AppStates {}
class OrderSuccessState extends AppStates {}
class HaveOrderLoadingState extends AppStates {}
class HaveOrderSuccessState extends AppStates {}
class GetMyOrderLoadingState extends AppStates {}
class GetMyOrderSuccessState extends AppStates {}
class GetMyOrderItemLoadingState extends AppStates {}
class GetMyOrderItemSuccessState extends AppStates {}
class ImageIntStates extends AppStates {}
class SelectLocation extends AppStates {
  final double distance;
  SelectLocation( this.distance);
}
class ImageErrorStates extends AppStates {
  final String error;

  ImageErrorStates( this.error);
}
class UpdateProductImageErrorStates extends AppStates {
  final String error;

  UpdateProductImageErrorStates( this.error);
}
class UpdateProductImageSuccessStates extends AppStates {}
class SelectImageSuccessStates extends AppStates {}
class SelectProductImageErrorStates extends AppStates {
  final String error;

  SelectProductImageErrorStates( this.error);
}
class AddToSalaSuccessStates extends AppStates {}
class AddToolSalaSuccessStates extends AppStates {}

class ImageSuccessStates extends AppStates {}
class GetLocationSuccessState extends AppStates {}

class GetUsersSuccessStates extends AppStates {}
class GetUserLoadingStates extends AppStates {}
class GetUserSuccessStates extends AppStates {}
class GetFoodShopsSuccessState extends AppStates{
  final String type;
  GetFoodShopsSuccessState(this.type);
}
