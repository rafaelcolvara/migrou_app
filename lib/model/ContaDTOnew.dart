class Sabata {
  ClienteDTO clienteDTO;
  VendedorDTO vendedorDTO;
  String dtUltimaCompra;
  double vlrComprasRealizadas;
  int qtdComprasRealizadas;
  double vlrCashBack;
  CampanhaDTO campanhaDTO;

  Sabata(
      {this.clienteDTO,
      this.vendedorDTO,
      this.dtUltimaCompra,
      this.vlrComprasRealizadas,
      this.qtdComprasRealizadas,
      this.vlrCashBack,
      this.campanhaDTO});

  Sabata.fromJson(Map<String, dynamic> json) {
    clienteDTO = json['clienteDTO'] != null
        ? new ClienteDTO.fromJson(json['clienteDTO'])
        : null;
    vendedorDTO = json['vendedorDTO'] != null
        ? new VendedorDTO.fromJson(json['vendedorDTO'])
        : null;
    dtUltimaCompra = json['dtUltimaCompra'];
    vlrComprasRealizadas = json['vlrComprasRealizadas'] == null ||
            json['vlrComprasRealizadas'] == 0
        ? 0.00
        : json['vlrComprasRealizadas'];
    qtdComprasRealizadas = json['qtdComprasRealizadas'];
    vlrCashBack = json['vlrCashBack'] == null || json['vlrCashBack'] == 0
        ? 0.00
        : json['vlrCashBack'];
    campanhaDTO = json['campanhaDTO'] != null
        ? new CampanhaDTO.fromJson(json['campanhaDTO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clienteDTO != null) {
      data['clienteDTO'] = this.clienteDTO.toJson();
    }
    if (this.vendedorDTO != null) {
      data['vendedorDTO'] = this.vendedorDTO.toJson();
    }
    data['dtUltimaCompra'] = this.dtUltimaCompra;
    data['vlrComprasRealizadas'] = this.vlrComprasRealizadas;
    data['qtdComprasRealizadas'] = this.qtdComprasRealizadas;
    data['vlrCashBack'] = this.vlrCashBack;
    if (this.campanhaDTO != null) {
      data['campanhaDTO'] = this.campanhaDTO.toJson();
    }
    return data;
  }
}

class ClienteDTO {
  String idCliente;
  int idCampanha;
  DTOPessoa pessoaDTO;

  ClienteDTO({this.idCliente, this.idCampanha, this.pessoaDTO});

  ClienteDTO.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    idCampanha = json['idCampanha'];
    pessoaDTO = json['pessoaDTO'] != null
        ? new DTOPessoa.fromJson(json['pessoaDTO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCliente'] = this.idCliente;
    data['idCampanha'] = this.idCampanha;
    if (this.pessoaDTO != null) {
      data['pessoaDTO'] = this.pessoaDTO.toJson();
    }
    return data;
  }
}

class DTOPessoa {
  String id;
  String nome;
  String email;
  String senha;
  int cpfCnpj;
  String dataCadastro;
  String dataNascimento;
  String nrCelular;
  bool flgEmailValido;
  String base64Foto;
  String segmentoComercial;
  String nomeNegocio;

  DTOPessoa(
      {this.id,
      this.nome,
      this.email,
      this.senha,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.nrCelular,
      this.flgEmailValido,
      this.base64Foto,
      this.segmentoComercial,
      this.nomeNegocio});

  DTOPessoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    dataNascimento = json['dataNascimento'];
    nrCelular = json['nrCelular'];
    flgEmailValido = json['flgEmailValido'];
    base64Foto = json['base64Foto'] != null
        ? base64Foto = json['base64Foto']
        : base64Foto = "";
    segmentoComercial = json['segmentoComercial'];
    nomeNegocio = json['nomeNegocio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['dataNascimento'] = this.dataNascimento;
    data['nrCelular'] = this.nrCelular;
    data['flgEmailValido'] = this.flgEmailValido;
    data['base64Foto'] = this.base64Foto;
    data['segmentoComercial'] = this.segmentoComercial;
    data['nomeNegocio'] = this.nomeNegocio;
    return data;
  }
}

class VendedorDTO {
  DTOPessoa pessoaDTO;
  String idVendedor;
  String nomeNegocio;
  String nomeSegmento;

  VendedorDTO(
      {this.pessoaDTO, this.idVendedor, this.nomeNegocio, this.nomeSegmento});

  VendedorDTO.fromJson(Map<String, dynamic> json) {
    pessoaDTO = json['pessoaDTO'] != null
        ? new DTOPessoa.fromJson(json['pessoaDTO'])
        : null;
    idVendedor = json['idVendedor'];
    nomeNegocio = json['nomeNegocio'];
    nomeSegmento = json['nomeSegmento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pessoaDTO != null) {
      data['pessoaDTO'] = this.pessoaDTO.toJson();
    }
    data['idVendedor'] = this.idVendedor;
    data['nomeNegocio'] = this.nomeNegocio;
    data['nomeSegmento'] = this.nomeSegmento;
    return data;
  }
}

class CampanhaDTO {
  String nomeCampanha;
  bool flgPercentualSobreCompras;
  bool flgValorFixo;
  double vlrTotalComprasValorFixo;
  int qtLancamentosPercentualSobreCompras;
  double vlrPremioValorFixo;

  CampanhaDTO(
      {this.nomeCampanha,
      this.flgPercentualSobreCompras,
      this.flgValorFixo,
      this.vlrTotalComprasValorFixo,
      this.qtLancamentosPercentualSobreCompras,
      this.vlrPremioValorFixo});

  CampanhaDTO.fromJson(Map<String, dynamic> json) {
    nomeCampanha = json['nomeCampanha'];
    flgPercentualSobreCompras = json['flgPercentualSobreCompras'];
    flgValorFixo = json['flgValorFixo'];
    vlrTotalComprasValorFixo = json['vlrTotalComprasValorFixo'] == null ||
            json["vlrTotalComprasValorFixo"] == 0
        ? 0.00
        : json['vlrTotalComprasValorFixo'];
    qtLancamentosPercentualSobreCompras =
        json['qtLancamentosPercentualSobreCompras'];
    vlrPremioValorFixo = json['vlrPremioValorFixo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeCampanha'] = this.nomeCampanha;
    data['flgPercentualSobreCompras'] = this.flgPercentualSobreCompras;
    data['flgValorFixo'] = this.flgValorFixo;
    data['vlrTotalComprasValorFixo'] = this.vlrTotalComprasValorFixo;
    data['qtLancamentosPercentualSobreCompras'] =
        this.qtLancamentosPercentualSobreCompras;
    data['vlrPremioValorFixo'] = this.vlrPremioValorFixo;
    return data;
  }
}
