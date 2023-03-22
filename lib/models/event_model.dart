class EventModel {
  int? idEvento;
  String? dscEvento;
  String? ttlEvento;
  String? fechaEvento;
  bool? completado;

  EventModel({this.idEvento, this.dscEvento, this.fechaEvento, this.completado, this.ttlEvento});
  factory EventModel.fromMap(Map<String,dynamic> map){
    return EventModel(
      idEvento: map['idEvento'],
      dscEvento: map['dscEvento'],
      fechaEvento: map['fechaEvento'],
      completado: map['completado'],
      ttlEvento : map['ttlEvento'],
    );
  }
}