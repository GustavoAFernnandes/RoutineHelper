class MesModel {
  final int? id;
  final String nomeMes;
  final String ano;

  MesModel({this.id, required this.nomeMes, required this.ano});

  Map<String, dynamic> toMap() => {
    'id': id,
    'nome_mes': nomeMes,
    'ano': ano,
  };
}