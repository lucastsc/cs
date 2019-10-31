import 'dart:async';
import 'package:college_snacks/blocs/bloc_provider.dart' as prefix0;

class FavoriteBloc implements prefix0.BlocBase{

  Map<String, dynamic> _favorites = {};

  final _favController = StreamController<Map<String, dynamic>>. broadcast();
  Stream<Map<String, dynamic>> get outFav => _favController.stream;

  void toggleFavorite(String restaurantID){
    if(_favorites.containsKey(restaurantID)) _favorites.remove(restaurantID);
    else _favorites[restaurantID] = true;

    _favController.sink.add(_favorites);
  }

  @override
  void dispose() {
    _favController.close();
  }

}