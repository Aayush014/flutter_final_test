class NotesModal {
  String note, description;
  int like;

  NotesModal._(
      {required this.note, required this.description, required this.like});

  factory NotesModal(Map json) {
    return NotesModal._(
        note: json['notes'],
        description: json['description'],
        like: json['like']);
  }

  Map modalToMap(NotesModal notes) {
    return {
      'notes': notes.note,
      'description': notes.description,
      'like': notes.like
    };
  }
}
