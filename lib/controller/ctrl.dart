import 'package:mobx/mobx.dart';

part 'ctrl.g.dart';

class Ctrl = CtrlBase with _$Ctrl;

abstract class CtrlBase with Store {

  @observable
  bool value = false;

  @action
  bool changeValue() {
    return (value=!value);
  }
}