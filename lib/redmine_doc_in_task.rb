require 'russian_workdays'
require 'action_view/helpers/url_helper'

module RedmineDocInTask
  include ActionView::Helpers::UrlHelper

  # Метод для получения URL документа
  def self.document_url(document, host)
    # Использование пользовательского хоста, если определено в настройках плагина
    if Setting.plugin_redmine_doc_in_task['override_host'] == '1' && !Setting.plugin_redmine_doc_in_task['host'].empty?
      host = Setting.plugin_redmine_doc_in_task['host']
    end
    Rails.application.routes.url_helpers.document_url(document, host: host)
  end
end

