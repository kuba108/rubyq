module Admin
  module Editors
    module BaseHelper

      def format_label(label)
        if label
          label
        else
          "&nbsp;"
        end
      end

    end
  end
end