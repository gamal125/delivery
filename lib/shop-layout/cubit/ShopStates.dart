abstract class ShopAppStates {}
class ShopAppInitialState extends ShopAppStates {}
class ShopAppChangeBottomNavBarState extends ShopAppStates {}
class ShopUpdateProductSuccessStates extends ShopAppStates {}
class ShopUpdateProductErrorStates extends ShopAppStates {
  final String error;
  ShopUpdateProductErrorStates( this.error);
}
class ShopCreateUserSuccessState extends ShopAppStates {}
class ShopCreateFoodSuccessState extends ShopAppStates {}
class ShopCreateFoodMenuSuccessState extends ShopAppStates {}
class GetMYFoodShopSuccessState extends ShopAppStates{
  final String type;
  GetMYFoodShopSuccessState(this.type);
}
class GetFoodMenuSuccessState extends ShopAppStates{
  final String type;
  final String restaurant;
  GetFoodMenuSuccessState(this.type,this.restaurant);
}
class GetMarketMenuSuccessState extends ShopAppStates{
  final String type;
  final String market;
  GetMarketMenuSuccessState(this.type,this.market);
}
class GetFoodMenuLoadingState extends ShopAppStates{}
class GetMarketMenuLoadingState extends ShopAppStates{}
class GetMYMarketShopSuccessState extends ShopAppStates{
  final String type;
  GetMYMarketShopSuccessState(this.type);
}
class ShopCreateUserErrorState extends ShopAppStates {
  final String error;
  ShopCreateUserErrorState( this.error);
}
class ShopCreateShopErrorState extends ShopAppStates {
  final String error;
  ShopCreateShopErrorState( this.error);
}
class ShopCreateShopMenuErrorState extends ShopAppStates {
  final String error;
  ShopCreateShopMenuErrorState( this.error);
}
class ShopLogoutLoadingState extends ShopAppStates {}
class ShopLogoutSuccessState extends ShopAppStates {}
class ShopImageIntStates extends ShopAppStates {}
class ShopImageMenuIntStates extends ShopAppStates {}
class ShopImageErrorStates extends ShopAppStates {
  final String error;
  ShopImageErrorStates( this.error);}
class ShopImageMenuErrorStates extends ShopAppStates {
  final String error;
  ShopImageMenuErrorStates( this.error);}
class ShopUpdateProductImageErrorStates extends ShopAppStates {
  final String error;
  ShopUpdateProductImageErrorStates( this.error);}
class ShopUpdateProductImageSuccessStates extends ShopAppStates {}
class ShopImageSuccessStates extends ShopAppStates {}
class ShopImageMenuSuccessStates extends ShopAppStates {}
class ShopGetLocationSuccessState extends ShopAppStates {}
class ShopGetUsersSuccessStates extends ShopAppStates {}
class ShopGetUserLoadingStates extends ShopAppStates {}
class ShopGetUserSuccessStates extends ShopAppStates {}
