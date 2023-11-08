# Evently - spersonalizowane wydarzenia w Trójmieście

Evently to innowacyjna aplikacja mobilna, którą stworzyłem, aby przekształcić sposób, w jaki odkrywasz wydarzenia w swoim mieście. Została stworzona podczas hackathonu Hack Heroes i korzysta z mojego własnego API, które pobiera dane z trójmiasto.pl.

Aplikacja mobilna, stworzona w Flutter, może zostać skompilowana na różne platformy, takie jak Android, iOS i Web. Dzięki temu możesz korzystać z Evently niezależnie od urządzenia, którego używasz.

API, które zasilam, zostało napisane w Pythonie i korzysta z bibliotek takich jak Flask i BeautifulSoup do scrapowania danych z internetu. API jest hostowane lokalnie i dostarcza dane do aplikacji Flutter.

## Technologie

Projekt został wykonany w następujących technologiach:

- **Flutter**: Framework do tworzenia aplikacji na różne platformy (Android, iOS, Web, itp.) w języku Dart.
- **Python**: Język programowania używany do stworzenia API, które dostarcza dane do aplikacji Flutter.

## API

API zostało napisane w Pythonie i korzysta z bibliotek takich jak Flask i BeautifulSoup do scrapowania danych z internetu. API jest hostowane lokalnie i dostarcza dane do aplikacji Flutter.

### Endpoints

- `/events`: Zwraca listę wydarzeń w formacie JSON. Każde wydarzenie zawiera tytuł, obraz, link, kategorię, miasto, lokalizację, datę i opis.

## Funkcje

### Ekran z wyborem daty i quizem

Na tym ekranie, użytkownik ma możliwość wyboru daty, na którą chce zobaczyć wydarzenia. Po wyborze daty, użytkownik jest przenoszony do quizu, który pomaga dopasować wydarzenia do jego preferencji. Quiz składa się z serii pytań dotyczących zainteresowań użytkownika, takich jak typ muzyki, rodzaj wydarzeń (np. koncerty, wystawy, warsztaty) i preferowana lokalizacja. Na podstawie odpowiedzi na te pytania, aplikacja generuje spersonalizowaną listę wydarzeń.

### Ekran z listą wydarzeń

Na tym ekranie, użytkownik może przeglądać listę wydarzeń. Każde wydarzenie na liście zawiera tytuł, obraz, datę i lokalizację. Użytkownik może dotknąć wydarzenia, aby zobaczyć więcej szczegółów.

### Ekran ze szczegółami wydarzenia

Na tym ekranie, użytkownik może zobaczyć więcej szczegółów na temat wybranego wydarzenia. Szczegóły obejmują tytuł, obraz, link, kategorię, miasto, lokalizację, datę i opis.

## Uruchomienie aplikacji na Androidzie:
- Pobierz i zainstaluj `evently.apk` z zakładki Releases
- Uruchom aplikację `Evently`

## Podgląd web

http://evently.franki.ovh/

## Licencja

MIT License

Copyright © 2023 fra

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
