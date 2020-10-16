
import 'package:sedc/db/database_provider.dart';

class Food {
  int id;
  String name;
  String calories;
  String cs;
  String numder;
  String loc;
  String mazud;
  String blg;
  bool isVegan;

  Food({this.id, this.name, this.calories, this.cs, this.isVegan, this.numder, this.loc, this.mazud, this.blg});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_CALORIES: calories,
      DatabaseProvider.COLUMN_CS: cs,
      DatabaseProvider.COLUMN_NUMDER: numder,
      DatabaseProvider.COLUMN_LOC: loc,
      DatabaseProvider.COLUMN_MAZUD:  mazud,
      DatabaseProvider.COLUMN_BLG: blg,
      DatabaseProvider.COLUMN_VEGAN: isVegan ? 1 : 0
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Food.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    calories = map[DatabaseProvider.COLUMN_CALORIES];
    numder = map[DatabaseProvider.COLUMN_NUMDER];
    cs = map[DatabaseProvider.COLUMN_CS];
    loc = map[DatabaseProvider.COLUMN_LOC];
    mazud = map[DatabaseProvider.COLUMN_MAZUD];
    blg = map[DatabaseProvider.COLUMN_BLG];
    isVegan = map[DatabaseProvider.COLUMN_VEGAN] == 1;
  }
}
