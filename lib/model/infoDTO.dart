class InforDTO {
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

  InforDTO(
      {this.id,
      this.nome,
      this.email,
      this.senha,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.nrCelular,
      this.flgEmailValido,
      this.base64Foto});

  InforDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    cpfCnpj = json['cpfCnpj'];
    dataCadastro = json['dataCadastro'];
    dataNascimento = json['dataNascimento'];
    nrCelular = json['nrCelular'];
    flgEmailValido = json['flgEmailValido'];
    base64Foto = json['base64Foto'];
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
    return data;
  }
}
