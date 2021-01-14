class VendVincCleinteDTO {
  String username;
  String nome;
  int cpfCnpj;
  String dataCadastro;
  String dataNascimento;
  bool flgEmailValido;

  VendVincCleinteDTO(
      {this.username,
      this.nome,
      this.cpfCnpj,
      this.dataCadastro,
      this.dataNascimento,
      this.flgEmailValido});

  VendVincCleinteDTO.fromJson(Map<String, dynamic> json) {
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
