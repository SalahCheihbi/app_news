abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class AppChangeBottomNavBarState extends NewsStates {}

//Buisness
class NewsGetBuisnessLodingState extends NewsStates {}

class NewsGetBuisnessSuccessState extends NewsStates {}

class NewsGetBuisnessErrorState extends NewsStates {
  final String error;
  NewsGetBuisnessErrorState(this.error);
}

class NewsSelectedBuisnessItemState extends NewsStates {}

//Sport
class NewsGetSportLodingState extends NewsStates {}

class NewsGetSportSuccessState extends NewsStates {}

class NewsGetSportErrorState extends NewsStates {
  final String error;
  NewsGetSportErrorState(this.error);
}

//Science
class NewsGetScienceLodingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLodingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;
  NewsGetSearchErrorState(this.error);
}
