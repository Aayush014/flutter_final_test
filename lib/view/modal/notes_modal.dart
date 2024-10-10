class NotesModal {
  String note, description;
  int like;
  int? id;

  NotesModal._(
      {required this.note, required this.description, required this.like,this.id});

  factory NotesModal(Map json) {
    return NotesModal._(
        note: json['notes'],
        description: json['description'],
        like: json['like'],
      id: json['id']??00
    );
  }

  Map modalToMap(NotesModal notes) {
    return {
      'notes': notes.note,
      'description': notes.description,
      'like': notes.like,
      'id':notes.id??00,
    };
  }
}
