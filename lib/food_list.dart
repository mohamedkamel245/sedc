
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sedc/db/database_provider.dart';
import 'package:sedc/events/delete_food.dart';
import 'package:sedc/events/set_foods.dart';
import 'package:sedc/food_form.dart';
import 'package:sedc/model/food.dart';

import 'bloc/food_bloc.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getFoods().then(
      (foodList) {
        BlocProvider.of<FoodBloc>(context).add(SetFoods(foodList));
      },
    );
  }

  showFoodDialog(BuildContext context, Food food, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(food.name,
         style:GoogleFonts.cairo(
                      textStyle: TextStyle(color: Colors.black,fontSize: 15, ),
                      ) 
        ),
        content: Text("بلاغ رقم ${food.id}",
          style:GoogleFonts.cairo(
                      textStyle: TextStyle(color: Colors.red,fontSize: 20, ),
                      )
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FoodForm(food: food, foodIndex: index),
              ),
            ),
            child: Text("تعديل"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(food.id).then((_) {
              BlocProvider.of<FoodBloc>(context).add(
                DeleteFood(index),
              );
              Navigator.pop(context);
            }),
            child: Text("حذف"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("إلغاء"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire food list scaffold");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("قدم بلاغك",
           style:GoogleFonts.cairo(
                      textStyle: TextStyle(color: Colors.amber,fontSize: 20, ),
                      )
        )),
      body: Container(
        child: BlocConsumer<FoodBloc, List<Food>>(
          
          builder: (context, foodList) {
            return ListView.separated(
              
              itemBuilder: (BuildContext context, int index) {
                print("foodList: $foodList");

                Food food = foodList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                     color: Colors.amber[400],
                    child: ListTile(
                      
                        title: Container(
                         
                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.black,     
                                      ),
                          child: Text("${food.name}",
                                      style:GoogleFonts.elMessiri(
                                      textStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 15, 
                                        fontWeight:FontWeight.w800
                                        ),
                                      ),
                                      ),
                        ),
                        subtitle: Text(
                          "رقم العداد : ${food.calories}\nرقم الهاتف : ${food.numder}\nالولاية  : ${food.cs}\nموقعك : ${food.loc}\nتفاصيل الموقع  : ${food.mazud}\nتفاصيل البلاغ  : ${food.blg}",
                            style:GoogleFonts.cairo(
                          textStyle: TextStyle(color: Colors.black45,fontSize: 15, ),
                          )
                        ),
                        trailing:   Container(
                         
                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.black,     
                                      ),
                          child: Text("تم التبليغ بنجاح",
                                      style:GoogleFonts.elMessiri(
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10, 
                                        fontWeight:FontWeight.w800
                                        ),
                                      ),
                                      ),
                        ),
                       
              
                     
                     
                        onTap: () => showFoodDialog(context, food, index)),
                  ),
                  
                );
                
              },
              itemCount: foodList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, foodList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add,color: Colors.black,),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => FoodForm()),
        ),
      ),
    );
  }
}
