# Приложение ToDo list

## Реализованные задачи, актуальные к ДЗ ч.4:
* Добавлен и работает flutter_lints, в коде нет необоснованных игноров правил
* Форматирование кода присутствует
* В коде есть разделение вёрстки и логики
* Навигация переписана на Navigator 2.0 - в отдельной сущности, отсутствуют явные переходы
* Текст длинных заметок на главном экране ограничен 3 строками, overflow отображается в соответствии с макетом
* Настроена светлая и тёмная тема в соответствии с палитрой согласно макету, меняется сразу при внесении изменений в соответствующие настройки устройства.
* Улучшен интерфейс при лендскейп-ориентации - SafeArea только при горизонтальном использовании устройства (особенно полезно для iPhone - см. скриншоты)

## Перечень реализованных прежде задач:
* Подключена локальная база данных Hive, приложение полноценно работает без интернета
* В Shared preferences сохраняется ревизия локальной базы данных
* Добавлена логика сравнения ревизий базы данных и бэкенда. Если при возобновления подключения к интернету ревизии не совпадают - например, были изменения списка без сети или были изменения на бэкенде без участия данного устройства - то, соответственно, данные на удалённом сервере обновляются (дошлётся то, что не смогло уйти в предыдущей сессии из-за ошибок/отсутствия сети) или обновляется список в локальной базе данных 
* Обработаны ошибки подключения сети и ошибки неудачных запросов к серверу (если не 200) для всех методов работы с api, при возникновении соответствующих ошибок пользователь ниформируется об отсутствии соединения с интернетом, при этом может полноценно продолжать работу с приложением
* Работа с данными организована в отдельной сущности, репозитории - объединяет в себе и синхронизирует работу клиента api, базы данных Hive и Shared Preferences
* State-management реализован с использованием стандарного Inherit Notifier, вся логика хранится в модели, отделена от вёрстки
* Написаны Unit-тесты для получения и отправки данных для 3 сущностей - Api client, Hive и Shared Preferences, для них сгенерированы методы тестирования с помощью пакета Mockito, добавлены mock задания для тестирования
* Выполнена вёрстка двух экранов по макету
* Присутствует логика всех возможностей приложения - добавление, редактирование, отметка выполненности, удаление, настройка даты и приоритетности выполнения задачи
* Настроен показ выполненных дел с логикой
* Добавлен пакет intl, настроена локализация, приложение доступно на русском и английском языках, изменения применяются при смене языка в настройках устройства
* Установлена иконка для iOS и Android
* Приложение подключено к бэкенду, настроены функции загрузки списка задач, создания новой задачи, её редактирования и удаления
* Настроена автоматическая загрузка списка задач при первом включении приложения и моментальное обновление при любых операциях с задачами
* Реализовано сохранение на диск устройства поступающих с бэкенда данных и их показ при отсутствии подключения к сети


# Ссылка на apk:

https://disk.yandex.ru/d/mvrrPNc-HA5b1g

# Screenshots

<div style="display: flex;">
  <img src="https://github.com/IgorFedoseev/ya_todo_app/blob/back_connection/assets/screenshots/main_screen.png" width="202">
  <img src="https://github.com/IgorFedoseev/ya_todo_app/blob/back_connection/assets/screenshots/editor_screen.png" width="200">
  <img src="https://github.com/IgorFedoseev/ya_todo_app/blob/master/assets/screenshots/dark_theme.png" width="204"> 
</div>
<div style="display: flex;">
  <img src="https://github.com/IgorFedoseev/ya_todo_app/blob/master/assets/screenshots/landscape_view.png" width="400">
</div>