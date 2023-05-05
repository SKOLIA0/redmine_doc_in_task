require_dependency 'documents_controller'
module DInTaskDocumentsControllerPatch
  # Метод для включения патча в DocumentsController
  def self.included(base)
    base.class_eval do
      alias_method :create_without_doc_in_task, :create # Создание псевдонима для метода create
      alias_method :create, :create_with_doc_in_task # Замена метода create на create_with_doc_in_task
    end
  end
  # Переопределение метода создания документа с созданием связанной задачи
  def create_with_doc_in_task
    create_without_doc_in_task # Вызов оригинального метода create
    # Если документ успешно сохранен и параметр create_related_task равен 1
    if @document.persisted? && params[:create_related_task] == '1'
      executor_field_id = @document.available_custom_fields.find { |cf| cf.name == 'Исполнитель' }&.id.to_s #выбор исполнителя
      assigned_to_id = params[:document][:custom_field_values][executor_field_id].first unless params[:document][:custom_field_values][executor_field_id].blank?
      host = request.host_with_port # Получение хоста с портом
      # Создание связанной задачи на основе документа
      RedmineDocInTask::DocumentIssueCreator.create_issue_from_document(@document, assigned_to_id, host, params)
    end
  end
end
# Включение патча в DocumentsController
DocumentsController.send(:include, DInTaskDocumentsControllerPatch)
