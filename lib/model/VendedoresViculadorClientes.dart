class VendVincCleinteDTO {
  String username;
  String nomeNegocio;
  String nomeSegmento;
  String nrCelular;
  String nome;
  int cpfCnpj;
  String dataCadastro;
  String dataNascimento;
  bool flgEmailValido;
  String urlFoto;

  VendVincCleinteDTO(
      {this.username,
      this.nomeNegocio,
      this.nomeSegmento,
      this.nrCelular,
      this.nome,
      this.urlFoto,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.flgEmailValido});

  VendVincCleinteDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nomeNegocio = json['nomeNegocio'];
    nomeSegmento = json['nomeSegmento'];
    nrCelular = json['nrCelular'];
    nome = json['nome'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    dataNascimento = json['dataNascimento'];
    flgEmailValido = json['flgEmailValido'];
    urlFoto = json['urlFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['nomeNegocio'] = this.nomeNegocio;
    data['nomeSegmento'] = this.nomeSegmento;
    data['nrCelular'] = this.nrCelular;
    data['nome'] = this.nome;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['dataNascimento'] = this.dataNascimento;
    data['flgEmailValido'] = this.flgEmailValido;
    data['urlFoto'] = this.urlFoto;
    return data;
  }
}
