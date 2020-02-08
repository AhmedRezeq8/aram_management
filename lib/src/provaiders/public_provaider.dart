import 'package:flutter/material.dart';

class SelectedVideoTypeProvider with ChangeNotifier {

  int selectedTypeId= 1;
  int get index => selectedTypeId;

  set index(int val){
    selectedTypeId= val;
    notifyListeners();
  }

  int _count = 0;
  int get count => _count;

  set count(int val){
    _count= val;
    notifyListeners();
  }

}

class SelectedDomainProvider with ChangeNotifier {

  int selectedDomainId= 1;
  int get index => selectedDomainId;

  set index(int val){
    selectedDomainId= val;
    notifyListeners();
  }

  

}

class SelectedSginProvider with ChangeNotifier {

  int selectedSign= 1;
  int get index => selectedSign;

  set index(int val){
    selectedSign= val;
    notifyListeners();
  }

  

}

