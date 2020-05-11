class CampanhaDTO {

    CampanhaDTO({this.nomeCampanha, this.flgPercentualSobreCompras, this.flgValorFixo, this.prcTotalLancamentosPercentualSobreCompras, this.qtLancamentosPercentualSobreCompras, this.vlrPremioValorFixo, this.vlrTotalComprasValorFixo});

    String nomeCampanha;

    bool flgPercentualSobreCompras;

    double prcTotalLancamentosPercentualSobreCompras;

    int qtLancamentosPercentualSobreCompras;

    bool flgValorFixo;

    double vlrTotalComprasValorFixo;

    double vlrPremioValorFixo;

  CampanhaDTO.fromJson(Map<String, dynamic> json):

    nomeCampanha = json['nomeCampanha'],
    flgPercentualSobreCompras = json['flgPercentualSobreCompras'],
    prcTotalLancamentosPercentualSobreCompras = json.containsKey('prcTotalLancamentosPercentualSobreCompras')?double.parse(json['prcTotalLancamentosPercentualSobreCompras'].toString()):0.0,
    qtLancamentosPercentualSobreCompras = json.containsKey('qtLancamentosPercentualSobreCompras')?json['qtLancamentosPercentualSobreCompras']:0,
    flgValorFixo = json.containsKey('flgValorFixo')?json['flgValorFixo']:false,
    vlrTotalComprasValorFixo = json.containsKey('vlrTotalComprasValorFixo')?double.parse(json['vlrTotalComprasValorFixo'].toString()):0.0,
    vlrPremioValorFixo = json.containsKey('vlrPremioValorFixo')?double.parse(json['vlrPremioValorFixo'].toString()):0.0;
 

  Map<String, dynamic> toJson() => {
      'nomeCampanha' :nomeCampanha,
      'flgPercentualSobreCompras' : flgPercentualSobreCompras,
      'prcTotalLancamentosPercentualSobreCompras': prcTotalLancamentosPercentualSobreCompras,
      'qtLancamentosPercentualSobreCompras': qtLancamentosPercentualSobreCompras,
      'flgValorFixo' : flgValorFixo,
      'vlrTotalComprasValorFixo': vlrTotalComprasValorFixo,
      'vlrPremioValorFixo': vlrPremioValorFixo
  };

}