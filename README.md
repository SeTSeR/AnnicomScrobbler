# AnnicomScrobbler
Программа для скробблинга прослушиваемой музыки на [annimon.com](https://annimon.com/str/nowplay.php)

## Установка
1. Установить [Stack](https://docs.haskellstack.org/en/stable/README/)
2. Склонировать репозиторий:
```
$ git clone https://github.com/SeTSeR/AnnicomScrobbler
```
3. В директории c проектом выполнить stack build:
```
$ cd AnnicomScrobbler/
$ stack build
```
4. В домашней директории создать конфигурационный файл .annicomscrobbler, заполненный в соответствии с 
форматом, указанным в документации к [модулю Preferences](doc/Services/Preferences.md).
5. Запустить программу с помощью stack exec:
```
$ stack exec AnnicomScrobbler-exe
```
