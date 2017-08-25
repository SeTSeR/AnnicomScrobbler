# Модуль Getter

Модуль предоставляет интерфейс для получения песни, проигрываемой в данный момент. Общение с плеером 
происходит через [D-Bus](http://www.freedesktop.org/wiki/Software/dbus), используется протокол [MPRIS](https://specifications.freedesktop.org/mpris-spec/latest/) 
версии 2.0.

## Предоставляемый интерфейс:

----

```Haskell
getSong :: IO (Maybe Song)
```
Получаeт проигрываемую песню, либо Nothing, если песню получить не удалось. О формате песни см. [модуль Song](Song.md)

----
