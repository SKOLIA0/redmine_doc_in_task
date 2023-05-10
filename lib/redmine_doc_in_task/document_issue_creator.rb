require 'russian_workdays'

module RedmineDocInTask
  class DocumentIssueCreator
   def self.create_issue_from_document(document, host, params)
      issue = Issue.new
      settings = Setting.plugin_redmine_doc_in_task
      issue.tracker_id = settings['tracker_id'].to_i
      issue.status_id = settings['status_id'].to_i
      issue.priority_id = settings['priority_id'].to_i
      issue.author_id = User.current.id
      issue.project = document.project
      issue.subject = document.title
      executor_field_id = document.available_custom_fields.find { |cf| cf.name == 'Исполнитель' }&.id.to_s #выбор исполнителя
      assigned_to_id = params[:document][:custom_field_values][executor_field_id] if params[:document][:custom_field_values][executor_field_id].present?
      issue.assigned_to_id = assigned_to_id.to_i
      issue.start_date = Date.today
      issue.due_date = calculate_due_date(issue.start_date, settings['days_to_add'].to_i)
      issue.description = "Ссылка на документ: #{RedmineDocInTask.document_url(document, host)}"
      issue.save
      copy_attachments(document, issue)
    end

    def self.copy_attachments(document, issue)
      # Проверяем, включено ли дублирование файлов в настройках плагина
      if Setting.plugin_redmine_doc_in_task['copy_attachments_enabled'] == '1'
        document.attachments.each do |attachment|
          if attachment
            new_attachment = attachment.dup
            new_attachment.update(container_id: issue.id, container_type: "Issue")
          end
        end
      end
    end


    def self.calculate_due_date(start_date, days_to_add)
      period1 = start_date + days_to_add.days
      holidays = RussianWorkdays::Collection.new(start_date..period1)
      end_date1 = period1 + holidays.holidays.size.days
      x = 0
      while x == 0 do
        date_r = RussianWorkdays::Day.new(end_date1.to_date)
        if date_r.work?
          x = 1
          return end_date1
        else
          end_date1 = end_date1 + 1.day
        end
      end
    end
  end
end
