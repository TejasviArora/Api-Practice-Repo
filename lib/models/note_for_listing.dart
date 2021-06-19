

class NoteForListing{
  String noteId;
  String noteTitle;

  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing({ this.noteId,  this.noteTitle,  this.createDateTime,  this.lastEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item){
    return  NoteForListing(
      noteId: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastEditDateTime: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null,
    );
  }
}