// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Pessoa on _PessoaBase, Store {
  final _$nomeAtom = Atom(name: '_PessoaBase.nome');

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

  final _$emailAtom = Atom(name: '_PessoaBase.email');

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

  final _$cpfAtom = Atom(name: '_PessoaBase.cpf');

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

  final _$senhaAtom = Atom(name: '_PessoaBase.senha');

  @override
  String get senha {
    _$senhaAtom.context.enforceReadPolicy(_$senhaAtom);
    _$senhaAtom.reportObserved();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.context.conditionallyRunInAction(() {
      super.senha = value;
      _$senhaAtom.reportChanged();
    }, _$senhaAtom, name: '${_$senhaAtom.name}_set');
  }

  final _$dataNascimentoAtom = Atom(name: '_PessoaBase.dataNascimento');

  @override
  DateTime get dataNascimento {
    _$dataNascimentoAtom.context.enforceReadPolicy(_$dataNascimentoAtom);
    _$dataNascimentoAtom.reportObserved();
    return super.dataNascimento;
  }

  @override
  set dataNascimento(DateTime value) {
    _$dataNascimentoAtom.context.conditionallyRunInAction(() {
      super.dataNascimento = value;
      _$dataNascimentoAtom.reportChanged();
    }, _$dataNascimentoAtom, name: '${_$dataNascimentoAtom.name}_set');
  }

  final _$flgVendedorAtom = Atom(name: '_PessoaBase.flgVendedor');

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

  final _$_PessoaBaseActionController = ActionController(name: '_PessoaBase');

  @override
  dynamic changeName(String newName) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.changeName(newName);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String newEmail) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.changeEmail(newEmail);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCpf(String newCpf) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.changeCpf(newCpf);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic chageSenha(String newSenha) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.chageSenha(newSenha);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDataDascimento(DateTime newDataNascimento) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.changeDataDascimento(newDataNascimento);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeVendedor(bool value) {
    final _$actionInfo = _$_PessoaBaseActionController.startAction();
    try {
      return super.changeVendedor(value);
    } finally {
      _$_PessoaBaseActionController.endAction(_$actionInfo);
    }
  }
}
