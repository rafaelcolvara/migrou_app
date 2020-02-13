// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Cliente on _ClienteBase, Store {
  final _$nomeAtom = Atom(name: '_ClienteBase.nome');

  @override
  String get nome {
    _$nomeAtom.context.enforceReadPolicy(_$nomeAtom);
    _$nomeAtom.reportObserved();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.context.conditionallyRunInAction(() {
      super.nome = value;
      _$nomeAtom.reportChanged();
    }, _$nomeAtom, name: '${_$nomeAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_ClienteBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$cpfAtom = Atom(name: '_ClienteBase.cpf');

  @override
  String get cpf {
    _$cpfAtom.context.enforceReadPolicy(_$cpfAtom);
    _$cpfAtom.reportObserved();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.context.conditionallyRunInAction(() {
      super.cpf = value;
      _$cpfAtom.reportChanged();
    }, _$cpfAtom, name: '${_$cpfAtom.name}_set');
  }

  final _$flgVendedorAtom = Atom(name: '_ClienteBase.flgVendedor');

  @override
  bool get flgVendedor {
    _$flgVendedorAtom.context.enforceReadPolicy(_$flgVendedorAtom);
    _$flgVendedorAtom.reportObserved();
    return super.flgVendedor;
  }

  @override
  set flgVendedor(bool value) {
    _$flgVendedorAtom.context.conditionallyRunInAction(() {
      super.flgVendedor = value;
      _$flgVendedorAtom.reportChanged();
    }, _$flgVendedorAtom, name: '${_$flgVendedorAtom.name}_set');
  }

  final _$_ClienteBaseActionController = ActionController(name: '_ClienteBase');

  @override
  dynamic changeName(String newName) {
    final _$actionInfo = _$_ClienteBaseActionController.startAction();
    try {
      return super.changeName(newName);
    } finally {
      _$_ClienteBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeVendedor(bool value) {
    final _$actionInfo = _$_ClienteBaseActionController.startAction();
    try {
      return super.changeVendedor(value);
    } finally {
      _$_ClienteBaseActionController.endAction(_$actionInfo);
    }
  }
}
