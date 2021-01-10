class MeuDTO {
  ClienteDTO clienteDTO;
  VendedorDTO vendedorDTO;
  String dtUltimaCompra;
  double vlrComprasRealizadas;
  int qtdComprasRealizadas;
  double vlrCashBack;
  CampanhaDTO campanhaDTO;

  MeuDTO(
      {this.clienteDTO,
      this.vendedorDTO,
      this.dtUltimaCompra,
      this.vlrComprasRealizadas,
      this.qtdComprasRealizadas,
      this.vlrCashBack,
      this.campanhaDTO});

  MeuDTO.fromJson(Map<String, dynamic> json) {
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
  String username;
  int idCampanha;
  String nome;
  int cpfCnpj;
  String dataCadastro;
  bool flgEmailValido;
  String tipoPessoa;

  ClienteDTO(
      {this.username,
      this.idCampanha,
      this.nome,
      this.cpfCnpj,
      this.dataCadastro,
      this.flgEmailValido,
      this.tipoPessoa});

  ClienteDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    idCampanha = json['idCampanha'];
    nome = json['nome'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    flgEmailValido = json['flgEmailValido'];
    tipoPessoa = json['tipoPessoa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['idCampanha'] = this.idCampanha;
    data['nome'] = this.nome;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['flgEmailValido'] = this.flgEmailValido;
    data['tipoPessoa'] = this.tipoPessoa;
    return data;
  }
}

class VendedorDTO {
  String username;
  String nome;
  int cpfCnpj;
  String dataCadastro;
  String dataNascimento;
  bool flgEmailValido;

  VendedorDTO(
      {this.username,
      this.nome,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.flgEmailValido});

  VendedorDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nome = json['nome'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    dataNascimento = json['dataNascimento'];
    flgEmailValido = json['flgEmailValido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['nome'] = this.nome;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['dataNascimento'] = this.dataNascimento;
    data['flgEmailValido'] = this.flgEmailValido;
    return data;
  }
}

class CampanhaDTO {
  String nomeCampanha;
  bool flgPercentualSobreCompras;
  double prcTotalLancamentosPercentualSobreCompras;
  int qtLancamentosPercentualSobreCompras;
  bool flgValorFixo;
  double vlrTotalComprasValorFixo;
  double vlrPremioValorFixo;

  CampanhaDTO(
      {this.nomeCampanha,
      this.flgPercentualSobreCompras,
      this.prcTotalLancamentosPercentualSobreCompras,
      this.qtLancamentosPercentualSobreCompras,
      this.flgValorFixo,
      this.vlrTotalComprasValorFixo,
      this.vlrPremioValorFixo});

  CampanhaDTO.fromJson(Map<String, dynamic> json) {
    nomeCampanha = json['nomeCampanha'];
    flgPercentualSobreCompras = json['flgPercentualSobreCompras'];
    prcTotalLancamentosPercentualSobreCompras =
        json['prcTotalLancamentosPercentualSobreCompras'] == null ||
                json['prcTotalLancamentosPercentualSobreCompras'] == 0
            ? 0.00
            : json['prcTotalLancamentosPercentualSobreCompras'];
    qtLancamentosPercentualSobreCompras =
        json['qtLancamentosPercentualSobreCompras'];
    flgValorFixo = json['flgValorFixo'];
    vlrTotalComprasValorFixo = json['vlrTotalComprasValorFixo'] == null ||
            json['vlrTotalComprasValorFixo'] == 0
        ? 0.00
        : json['vlrTotalComprasValorFixo'];
    vlrPremioValorFixo =
        json['vlrPremioValorFixo'] == null || json['vlrPremioValorFixo'] == 0
            ? 0.00
            : json['vlrPremioValorFixo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeCampanha'] = this.nomeCampanha;
    data['flgPercentualSobreCompras'] = this.flgPercentualSobreCompras;
    data['prcTotalLancamentosPercentualSobreCompras'] =
        this.prcTotalLancamentosPercentualSobreCompras;
    data['qtLancamentosPercentualSobreCompras'] =
        this.qtLancamentosPercentualSobreCompras;
    data['flgValorFixo'] = this.flgValorFixo;
    data['vlrTotalComprasValorFixo'] = this.vlrTotalComprasValorFixo;
    data['vlrPremioValorFixo'] = this.vlrPremioValorFixo;
    return data;
  }
}
