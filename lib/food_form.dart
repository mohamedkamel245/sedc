
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sedc/bloc/food_bloc.dart';
import 'package:sedc/db/database_provider.dart';
import 'package:sedc/events/add_food.dart';
import 'package:sedc/events/update_food.dart';
import 'package:sedc/model/food.dart';

class FoodForm extends StatefulWidget {
  final Food food;
  final int foodIndex;

  FoodForm({this.food, this.foodIndex});

  @override
  State<StatefulWidget> createState() {
    return FoodFormState();
  }
}

class FoodFormState extends State<FoodForm> {
  String _name;
  String _calories;
  String _numder;
  var _cs;
  dynamic _loc;
  String _mazud;
  String _blg;
  bool _isVegan = false;

  final locationController = TextEditingController();

  LocationData currentLocation;
  Location location = Location();
  double letit = 36.2018, lng = 29.6377;
  GoogleMapController _mapController;
  bool buscando = false;
  String header = "";
  bool mal = true;
 List<Address> addresses;
 void getUserLocation()async{
   currentLocation = await location.getLocation();
   setState(() {
     letit = currentLocation.latitude;
     lng = currentLocation.longitude;
   });
    final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
      // addresses = await Geocoder.google("AIzaSyBdEmsLsyuD7_3p-rul4_cP29WEUi9b0U8" ,language: "ar").findAddressesFromCoordinates(coordinates);
      addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {
        locationController.text = addresses.first.addressLine??"";
        header = addresses.first.thoroughfare??"";
        print("======${addresses.first}");
        mal = false;
        
      });
    // locationController.text = placemark[0].name;
    // _mapController.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

  void onCreated(GoogleMapController controller){
    _mapController = controller;
  }
  // void onCameraMove(CameraPosition position)async{
  //   setState(() {});
  //    buscando = false;
  //   currentLocation = position;
  // }

  gunAdderss(double lt, double ld) async{
     final coordinates = new Coordinates(lt,ld);
      // addresses = await Geocoder.google("AIzaSyBdEmsLsyuD7_3p-rul4_cP29WEUi9b0U8" ,language: "ar").findAddressesFromCoordinates(coordinates);
      addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

      setState(() {
        header = addresses.first.addressLine??"";
        
        print("======================$header===================");
        
      });
  }



 bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    }

    );
  }

    List<String> _titletypee=<String>[
    'ولاية الخرطوم',
    'ولاية الجزيرة',
    'ولاية البحر الأحمر',
    'ولاية كسلا',
    'ولاية القضارف',
    'ولاية سنار',
    'ولاية النيل الأبيض',
    '	ولاية النيل الأزرق',
    'الولاية الشمالية',
    'ولاية نهر النيل',
    'ولاية شمال كردفان',
    'ولاية غرب كردفان',
    'ولاية جنوب كردفان',
    'ولاية شمال دارفور',
    'ولاية غرب دارفور',
    'ولاية جنوب دارفور',
    'ولاية شرق دارفور',
    'ولاية وسط دارفور',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Padding(
      padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            initialValue: _name,
            decoration: InputDecoration(hintText: 'الإسم',labelStyle:GoogleFonts.mada(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        
                                          fontWeight:FontWeight.w800
                                          ),

                                        ),
                                        icon: Icon(Icons.person_outline, color: Colors.black,),
                                      border: InputBorder.none,
                                        ),
                                        
         
            style: TextStyle(fontSize: 13),
            validator: (String value) {
              if (value.isEmpty) {
                return 'مطلوب الاسم';
              }

              return null;
            },
            onSaved: (String value) {
              _name = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNUMDERId() {
    return Padding(
       padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            initialValue: _calories,
            decoration: InputDecoration(hintText: 'رقم الهاتف',
            labelStyle:GoogleFonts.mada(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        
                                          fontWeight:FontWeight.w800
                                          ),

                                        ),
                                        icon: Icon(Icons.phone, color: Colors.black,),
                                      border: InputBorder.none
            ),
            keyboardType: TextInputType.number,
           style: TextStyle(fontSize: 13),
            validator: (String value) {
              int calories = int.tryParse(value);

              if (calories == null || calories <= 0) {
                return 'Calories must be greater than 0';
              }

              return null;
            },
            onSaved: (String value) {
              _calories = value;
            },
          ),
        ),
      ),
    );
  }

    Widget _buildNumder() {
      return Padding(
         padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
        child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            initialValue: _numder,
            decoration: InputDecoration(hintText: 'رقم العداد',
            labelStyle:GoogleFonts.mada(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        
                                          fontWeight:FontWeight.w800
                                          ),

                                        ),
                                        icon: Icon(Icons.call_to_action, color: Colors.black,),
                                      border: InputBorder.none
            ),
            keyboardType: TextInputType.number,
           style: TextStyle(fontSize: 13),
            validator: (String value) {
              int numder = int.tryParse(value);

              if (numder == null || numder <= 0) {
                return 'numder must be greater than 0';
              }

              return null;
            },
            onSaved: (String value) {
              _numder = value;
            },
          ),
        ),
    ),
      );
  }

  Widget _buildCs() {
 return Material(
 child: Container(
   padding: EdgeInsets.all(20.0),
   child: new Form(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         new Container(
                            child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                Icons.business,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: DropdownButton(
                                items: _titletypee
                                    .map((valu) => DropdownMenuItem(
                                          child: Text(
                                            valu,
                                            style:GoogleFonts.elMessiri(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15, 
                                        fontWeight:FontWeight.w800
                                        ),
                                      ),
                                          ),
                                          value: valu,
                                        ))
                                    .toList(),
                                onChanged: (selectedAccountType) {
                                  setState(() {
                                    _cs = selectedAccountType;
                                  });
                                },
                                value: _cs,
                                isExpanded: false,
                                hint: Text("ادخل الولاية",
                                style:GoogleFonts.elMessiri(
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12, 
                                        fontWeight:FontWeight.w800
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        )
                        ),
       ],),),
 ),
 );
           
  }
    Widget _buildLoc() {
    return Padding(
      padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            controller: locationController,
            decoration: InputDecoration(
                                        icon: Icon(Icons.location_on, color: Colors.black,),
                                      border: InputBorder.none,
                                        ),
                                        
         
            style: TextStyle(fontSize: 13),
            validator: (String value) {
              if (value.isEmpty) {
                return 'مطلوب ';
              }

              return null;
            },
            onSaved: (String value) {
              _loc= value;
            },
          ),
        ),
      ),
    );
  }

    Widget _buildMazud() {
   return Padding(
      padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            initialValue: _mazud,
            decoration: InputDecoration(hintText: 'مزيد من التفاصيل عن عنوانك',labelStyle:GoogleFonts.mada(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        
                                          fontWeight:FontWeight.w800
                                          ),

                                        ),
                                        icon: Icon(Icons.add_location, color: Colors.black,),
                                      border: InputBorder.none,
                                        ),
                                        
         
            style: TextStyle(fontSize: 13),
            validator: (String value) {
              if (value.isEmpty) {
                return 'مطلوب ';
              }

              return null;
            },
            onSaved: (String value) {
              _mazud = value;
            },
          ),
        ),
      ),
    );
  }

      Widget _buildBlg() {
   return Padding(
      padding:   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            initialValue: _blg,
            decoration: InputDecoration(hintText: 'تفاصيل البلاغ',labelStyle:GoogleFonts.mada(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        
                                          fontWeight:FontWeight.w800
                                          ),

                                        ),
                                        icon: Icon(Icons.person_outline, color: Colors.black,),
                                      border: InputBorder.none,
                                        ),
                                        
         
            style: TextStyle(fontSize: 13),
            validator: (String value) {
              if (value.isEmpty) {
                return 'مطلوب ';
              }

              return null;
            },
            onSaved: (String value) {
              _blg = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIsVegan() {
    return SwitchListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("اضغط علي العلامة", 
         style:GoogleFonts.elMessiri(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15, 
                                          fontWeight:FontWeight.w800
                                          ),
                                        ),),
      ),
      value: _isVegan,
      onChanged: (bool newValue) => setState(() {
        _isVegan = newValue;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
        _name = widget.food.name;
        _calories = widget.food.calories;
        _numder = widget.food.numder;
       _cs = widget.food.cs;
       _loc = widget.food.loc;
       _mazud = widget.food.mazud;
       _blg = widget.food.blg;
      _isVegan = widget.food.isVegan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("تقديم البلاغ",
          style:GoogleFonts.cairo(
                      textStyle: TextStyle(color: Colors.amber,fontSize: 20, ),
                      )
        )),
      body: 
          Stack(
            children: <Widget>[
                 GoogleMap(
                onTap: (LatLng newlat ){
setState(() {
  letit = newlat.latitude;
  lng = newlat.longitude;
  gunAdderss(newlat.latitude,newlat.longitude);

});
                },
                initialCameraPosition: CameraPosition(target: LatLng(letit, lng), zoom: 15.86),
                minMaxZoomPreference: MinMaxZoomPreference(10.5, 16.8),
                mapToolbarEnabled: true,
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId("log1"),
                     position: LatLng(letit, lng), 
                     infoWindow: InfoWindow(snippet: header)
                     )
                     },
                // onCameraMove: onCameraMove,
                onMapCreated: onCreated,
                onCameraIdle: () async{
                  buscando = true;
                  setState(() {});
                  // getMoneCamera();
                  getUserLocation();
                },

              ),
            
             Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'images/Untitled-trr.png',
                  width: 150.0,
                  height: 280.0,
                )),
          
               Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
          ),
        
              Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: ListView(

                    
                    
                    children: <Widget>[
                      _buildName(),
                      _buildNumder(),
                      _buildNUMDERId(),
                      _buildCs(),
                      _buildLoc(),
                      _buildMazud(),
                      _buildBlg(),

                      _buildIsVegan(),

                      widget.food == null
                          ? RaisedButton(

                            color: Colors.green,
                              child: Text(
                                'تقديم البلاغ',
                                   style:GoogleFonts.elMessiri(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight:FontWeight.w800
                                        ),
                                      ),
                              ),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }

                                _formKey.currentState.save();

                                Food food = Food(
                                  name: _name,
                                  calories: _calories,
                                  numder: _numder,
                                  cs: _cs,
                                  loc: _loc,
                                  mazud: _mazud,
                                  blg: _blg,
                                  isVegan: _isVegan,
                                );

                                DatabaseProvider.db.insert(food).then(
                                      (storedFood) => BlocProvider.of<FoodBloc>(context).add(
                                        AddFood(storedFood),
                                      ),
                                    );

                                Navigator.pop(context);
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text(
                                    "تحديث",
                                    style: TextStyle(color: Colors.blue, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      print("form");
                                      return;
                                    }

                                    _formKey.currentState.save();

                                    Food food = Food(
                                      name: _name,
                                      calories: _calories,
                                      numder: _numder,
                                      cs: _cs,
                                      loc: _loc,
                                      mazud: _mazud,
                                      blg: _blg,
                                      isVegan: _isVegan,
                                    );

                                    DatabaseProvider.db.update(widget.food).then(
                                          (storedFood) => BlocProvider.of<FoodBloc>(context).add(
                                            UpdateFood(widget.foodIndex, food),
                                          ),
                                        );

                                    Navigator.pop(context);
                                  },
                                ),
                                RaisedButton(
                                  child: Text(
                                    "إلغاء",
                                    style: TextStyle(color: Colors.red, fontSize: 16),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        
      
    );
  }
}
