# Evently - Projekt Hackathonowy

Ten projekt został stworzony na hackathon Hack Heroes. Jest to aplikacja mobilna stworzona w Flutter, która korzysta z API napisanego w Pythonie.<br>
Służy ona do wyświetlania spersonalizowanych listy wydarzeń dostarczanych przez API, pobieranych z trójmiasto.pl.

## Technologie

Projekt został wykonany w następujących technologiach:

- **Flutter**: Framework do tworzenia aplikacji na różne platformy (Android, iOS, Web, itp.) w języku Dart.
- **Python**: Język programowania używany do stworzenia API, które dostarcza dane do aplikacji Flutter.

## API

API zostało napisane w Pythonie i korzysta z bibliotek takich jak Flask i BeautifulSoup do scrapowania danych z internetu. API jest hostowane lokalnie i dostarcza dane do aplikacji Flutter.

### Endpoints

- `/events`: Zwraca listę wydarzeń w formacie JSON. Każde wydarzenie zawiera tytuł, obraz, link, kategorię, miasto, lokalizację, datę i opis.

## Aplikacja Flutter

Aplikacja Flutter jest aplikacją mobilną, która wyświetla listę wydarzeń dostarczanych przez API. Użytkownik może przeglądać wydarzenia, przeglądać szczegóły wydarzenia i przeglądać wydarzenia na mapie.


### Ekran z listą wydarzeń

Na tym ekranie, użytkownik może przeglądać listę wydarzeń. Każde wydarzenie na liście zawiera tytuł, obraz, datę i lokalizację. Użytkownik może dotknąć wydarzenia, aby zobaczyć więcej szczegółów.

### Ekran ze szczegółami wydarzenia

Na tym ekranie, użytkownik może zobaczyć więcej szczegółów na temat wybranego wydarzenia. Szczegóły obejmują tytuł, obraz, link, kategorię, miasto, lokalizację, datę i opis.