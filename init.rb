# Этот файл используется для инициализации плагина и его настроек
require 'redmine'
# Загружаем патчи
require_dependency File.expand_path('../app/controllers/d_in_task_documents_controller_patch', __FILE__)

# Описание плагина
Redmine::Plugin.register :redmine_doc_in_task do
  # Информация о плагине
  name 'Redmine Doc In Task plugin'
  author 'Слепченко Николай'
  description 'При создания документа добавлен чекбокс "Создать связанную задачу". Если категория документа совпадает с категорией, указанной в настройках плагина, чекбокс будет видимым и по умолчанию отмечен.'
  version '0.1.0'
  url 'https://t.me/NikolajSlep'
  author_url 'https://github.com/SKOLIA0'

  # Настройки плагина
  settings default: { 'tracker_id' => '', 'status_id' => '', 'priority_id' => '', 'document_category_id' => '', 'host' => '' },
           partial: 'settings/redmine_doc_in_task_settings'
  # Переопределение оригинального контроллера документов
  # Используем наш патч, чтобы добавить дополнительную функциональность
  Rails.configuration.to_prepare do
    DocumentsController.send(:include, DInTaskDocumentsControllerPatch)
    Document.send(:include, DocumentPatch)
  end
end
