class WidgetUpdateService

  def initialize(widget)
    @widget = widget
  end

  def perform
    self.send("#{@widget.name}_widget")
  rescue
    # nothing
  end

  private

  def image_widget
    if @widget.attachments.size > 1
      @widget.attachments.each do |attachment|
        attachment.purge unless attachment == @widget.attachments.last
      end
    end
  end

end