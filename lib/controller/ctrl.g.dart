// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ctrl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Ctrl on CtrlBase, Store {
  final _$valueAtom = Atom(name: 'CtrlBase.value');

  @override
  bool get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(bool value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$CtrlBaseActionController = ActionController(name: 'CtrlBase');

  @override
  bool changeValue() {
    final _$actionInfo = _$CtrlBaseActionController.startAction();
    try {
      return super.changeValue();
    } finally {
      _$CtrlBaseActionController.endAction(_$actionInfo);
    }
  }
}
