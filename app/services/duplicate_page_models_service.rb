# Service walks through sections, wrappers and widgets of specific page and duplicates them for other page.

class DuplicatePageModelsService

  def initialize(source_page, target_page)
    @source_page = source_page
    @target_page = target_page
  end

  def duplicate_models
    @source_page.sections.order(created_at: :asc).each do |section|
      Section.transaction do
        new_section = section.dup
        new_section.page_id = @target_page.id
        new_section.save!

        section.wrappers.order(created_at: :asc).each do |wrapper|
          new_wrapper = wrapper.dup
          new_wrapper.section_id = new_section.id
          new_wrapper.save!

          wrapper.wrapper_widgets.order(created_at: :asc).each do |wrapper_widget|
            new_widget = wrapper_widget.widget.dup
            new_widget.save!

            new_wrapper_widget = wrapper_widget.dup
            new_wrapper_widget.wrapper_id = new_wrapper.id
            new_wrapper_widget.widget_id = new_widget.id
            new_wrapper_widget.save!
          end
        end
      end
    end
  end

end