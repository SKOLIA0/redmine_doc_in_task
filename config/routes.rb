# В этом файле определяются маршруты, специфичные для плагина
# В данном случае, мы добавляем маршрут для настроек плагина
Rails.application.routes.draw do
  # Этот маршрут будет обрабатывать запросы к настройкам плагина в административном интерфейсе Redmine
  get 'redmine_doc_in_task_settings', to: 'redmine_doc_in_task_settings#index'

  # Этот маршрут будет обрабатывать отправку формы с настройками плагина
  post 'redmine_doc_in_task_settings', to: 'redmine_doc_in_task_settings#update'
end
