# Модуль Preferences

Модуль предоставляет интерфейс для работы с конфигурацией. Конфигурация загружается из файла $XDG_CONFIG_HOME/annicomscrobbler.

## Синтаксис конфигурационного файла

```
<property> = <value>
```

Возможные значения для property:
* playerName - строка, название используемого плеера. Подходит любой плеер, поддерживающий протокол [MPRIS](https://specifications.freedesktop.org/mpris-spec/latest/) 
версии 2.0.
* annicomLogin - логин пользователя на <https://annimon.com>
* annicomToken - токен пользователя, можно получить со страницы [nowplay](https://annimon.com/str/nowplay.php)
* logFileName - путь к файлу с логом
* storeFileName - путь к файлу, в котором хранятся данные о проигрываемой музыке

## Предоставляемый интерфейс

----

```Haskell
playerName :: IO (Maybe String)
```
Возвращает название плеера, либо IO Nothing, если последнее отсутствует в конфигурационном файле.

----

```Haskell
annicomLogin :: IO (Maybe String)
```
Возвращает логин, либо IO Nothing, если данное поле не заполнено.

----

```Haskell
annicomToken :: IO (Maybe String)
```
Возвращает токен, либо IO Nothing, если данное поле не заполнено.

----

```Haskell
logFileName :: IO (Maybe String)
```
Возвращает путь к файлу лога, либо IO Nothing, если данное поле не заполнено.

---

```Haskell
storeFileName :: IO (Maybe String)
```
Возвращает путь к файлу хранилища, либо IO Nothing, если данное поле не заполнено.

----
