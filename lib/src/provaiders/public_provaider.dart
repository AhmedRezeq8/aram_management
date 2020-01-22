import 'package:flutter/material.dart';

class SelectedVideoTypeProvider with ChangeNotifier {

  int _selectedTypeId= 0;
  int get index => _selectedTypeId;

  set index(int val){
    _selectedTypeId= val;
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

  int _selectedDomainId= 0;
  int get index => _selectedDomainId;

  set index(int val){
    _selectedDomainId= val;
    notifyListeners();
  }

  int _count = 0;
  int get count => _count;

  set count(int val){
    _count= val;
    notifyListeners();
  }

}


