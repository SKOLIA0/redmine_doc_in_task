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
      host = request.host_with_port # Получение хоста с портом
      # Создание связанной задачи на основе документа
      RedmineDocInTask::DocumentIssueCreator.create_issue_from_document(@document, host, params)
    end
  end
end
# Включение патча в DocumentsController
DocumentsController.send(:include, DInTaskDocumentsControllerPatch)
