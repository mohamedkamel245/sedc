
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedc/events/add_food.dart';
import 'package:sedc/events/delete_food.dart';
import 'package:sedc/events/food_event.dart';
import 'package:sedc/events/set_foods.dart';
import 'package:sedc/events/update_food.dart';
import 'package:sedc/model/food.dart';



class FoodBloc extends Bloc<FoodEvent, List<Food>> {
  @override
  List<Food> get initialState => List<Food>();

  @override
  Stream<List<Food>> mapEventToState(FoodEvent event) async* {
    if (event is SetFoods) {
      yield event.foodList;
    } else if (event is AddFood) {
      List<Food> newState = List.from(state);
      if (event.newFood != null) {
        newState.add(event.newFood);
      }
      yield newState;
    } else if (event is DeleteFood) {
      List<Food> newState = List.from(state);
      newState.removeAt(event.foodIndex);
      yield newState;
    } else if (event is UpdateFood) {
      List<Food> newState = List.from(state);
      newState[event.foodIndex] = event.newFood;
      yield newState;
    }
  }
}
