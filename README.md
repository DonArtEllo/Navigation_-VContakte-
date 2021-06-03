# Домашнее задание к занятию "Структура проекта и жизненный цикл приложения"

В рамках домашней работы мы научимся создавать отдельные таргеты в Xcode проекте, подключать и использовать внутренние библиотеки и использовать флаги компиляции.

## Правила выполнения домашней работы

* Домашнее задание выполняется на базе проекта для Вконтакте. Изучите [инструкцию](https://github.com/netology-code/iosint-homeworks/blob/main/Pull%20request's%20guideline.md) по сдаче домашних заданий через Pull Request. В поле для сдачи работы прикрепите ссылку на ваш проект на Github.
* Все задачи обязательны к выполнению для получения зачета, кроме задач со звездочкой. Присылать на проверку можно каждую задачу по отдельности или все задачи вместе. Во время проверки по частям ваша домашняя работа будет со статусом "На доработке".
* Любые вопросы по решению задач задавайте в чате Slack.

## Задача 1
1. Добавить новый таргет из шаблона Framework с названием StorageService.
2. Перенести в таргет StorageService файлы StorageService и Post. Эти файлы не должны быть добавлены в таргет основного приложения.
3. Добавить с проект необходимые модификаторы доступа `public` и импорты фреймворка StorageService для успешного запуска проекта.

## Задача 2
1. Создать дубликат текущей схемы проекта, настроить запуск приложения с Release конфигурацией.
2. На экране `ProfileViewController` настроить разный цвет фона для Debug и Release сборки с помощью флага компиляции DEBUG.
3. Запустить обе схемы и проверить, что цвет фона меняется.
