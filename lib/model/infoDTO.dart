class InforDTO {
  String username;
  String nome;
  String email;
  String senha;
  int cpfCnpj;
  String dataCadastro;
  String dataNascimento;
  String nrCelular;
  bool flgEmailValido;
  String urlFoto;

  InforDTO(
      {this.username,
      this.nome,
      this.senha,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.nrCelular,
      this.flgEmailValido,
      this.urlFoto});

  InforDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nome = json['nome'];
    senha = json['senha'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    dataNascimento = json['dataNascimento'];
    nrCelular = json['nrCelular'];
    flgEmailValido = json['flgEmailValido'];
    urlFoto = json['urlFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    data['cpfCnpj'] = this.cpfCnpj;
    data['dataCadastro'] = this.dataCadastro;
    data['dataNascimento'] = this.dataNascimento;
    data['nrCelular'] = this.nrCelular;
    data['flgEmailValido'] = this.flgEmailValido;
    data['urlFoto'] = this.urlFoto;
    return data;
  }
}
