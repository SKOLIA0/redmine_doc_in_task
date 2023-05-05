# Плагин Redmine 5.0.1 Doc In Task

Плагин для создания связанных задач при создании документа в Redmine.

## Установка

1. Перейдите в каталог `plugins` вашего Redmine:
```bash
cd /opt/redmine/plugins
```
2. Клонируйте репозиторий плагина:
```bash
git clone https://github.com/SKOLIA0/redmine_doc_in_task.git
```
3. Перейдите в корневой каталог Redmine и выполните установку гема:

```bash
cd /opt/redmine
bundle add russian_workdays
```
4. Перезапустите ваше Redmine-приложение.

## Использование
1. Войдите в Redmine и перейдите в "Администрирование" > Настраиваемые поля > Документы и там присутствует поле пользователь: 
  Формат: Пользователь
  Имя: Исполнитель
  Отображение: выпадающий список
  Обязательное: активен флажок
нажмите кнопку сохранить.
2. Войдите в Redmine и перейдите в "Администрирование" > "Настройки плагинов" > "Redmine Doc In Task plugin".
3. Настройте параметры плагина и сохраните изменения.
4. Теперь при создании документа с выбранной категорией будет отображаться чекбокс "Создать связанную задачу".

## Удаление плагина

1. Перейдите в корневой каталог Redmine, откройте файл Gemfile и удалите строку похожую на **gem "russian_workdays", "~> 2.6"**, сохраните Gemfile
```bash
cd  /opt/redmine
nano Gemfile
```
2. Удалите папку плагина из каталога `plugins`:
```bash
cd /opt/redmine/plugins
rm -rf redmine_doc_in_task
```
3. Перезапустите ваше Redmine-приложение.