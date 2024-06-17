import 'dart:developer';

class Book{
  String title;
  String summary;

  Book(this.title, this.summary);

  String getTitle() {
    return title;
  }
}

void main() {
    Book idk = Book("random title", "random summary");
    print(idk.getTitle());
}
