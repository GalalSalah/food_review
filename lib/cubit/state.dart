abstract class RestaurantStates{}
class InitialState extends RestaurantStates{}
class ChangeBottomNavState extends RestaurantStates{}
class GetRestaurantSuccessState extends RestaurantStates{}
class GetRestaurantLoadingState extends RestaurantStates{}
class GetRestaurantErrorState extends RestaurantStates{
  final String error;
  GetRestaurantErrorState(this.error);
}
class GetDetailsRestaurantSuccessState extends RestaurantStates{}
class GetDetailsRestaurantLoadingState extends RestaurantStates{}
class GetDetailsRestaurantErrorState extends RestaurantStates{
  final String error;
  GetDetailsRestaurantErrorState(this.error);
}
class GetSearchRestaurantSuccessState extends RestaurantStates{}
class GetSearchRestaurantLoadingState extends RestaurantStates{}
class GetSearchRestaurantErrorState extends RestaurantStates{
  final String error;
  GetSearchRestaurantErrorState(this.error);
}
class GetReviewRestaurantSuccessState extends RestaurantStates{}
class GetReviewRestaurantLoadingState extends RestaurantStates{}
class GetReviewRestaurantErrorState extends RestaurantStates{
  final String error;
  GetReviewRestaurantErrorState(this.error);
}


class RestaurantCreateDatabaseState extends RestaurantStates{}
class RestaurantInsertToDatabaseSuccessfullyState extends RestaurantStates{}
class RestaurantInsertToDatabaseErrorState extends RestaurantStates{
  final String error;
  RestaurantInsertToDatabaseErrorState(this.error);
}


class AppChangeModeState extends RestaurantStates{}