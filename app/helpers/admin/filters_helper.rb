module Admin::FiltersHelper

  def text_filter(form, name, label, args = {})
    html = ""

    html += "
        <div class='text-filter form-group'>
          <div class='input-label'>
            <label for='#{name}'>#{label}</label>
          </div>
          <div class='input-group mb-3'>
            <div class='input-group-prepend'>
              <span class='input-group-text'><span class='fa fa-adjust'></span></span>
            </div>
            <input type='hidden' value='#{name}_cont'/>"
    html += form.text_field (name + '_cont').to_sym, id: name, class: 'form-control', value: filter_value(name + '_cont')
    html += "
          </div>
        </div>"
    raw html.html_safe
  end

  def number_filter(form, name, label, args = {})
    html = ""

    html += "
        <div class='text-filter form-group'>
          <div class='input-label'>
            <label for='#{name}'>#{label}</label>
          </div>
          <div class='input-group'>
            <span class='input-group-addon'><span class='fa fa-adjust'></span></span>
            <input type='hidden' value='#{name}_eq'/>"
    html += form.text_field (name + '_eq').to_sym, id: name, class: 'form-control', value: filter_value(name + '_eq')
    html += "
          </div>
        </div>"
    raw html.html_safe
  end

  def select_filter(form, name, label, data = {}, data_config = {},  args = {})
    selected = data_config[:selected]
    if params[:q]
      selected = filter_value(name + '_eq')
    end
    text_field = form.select(name + '_eq', data.collect {|d| [ d[1], d[0] ] }, { include_blank: "#{ t('filter.all') }", selected: selected }, { class: 'custom-select', data: { style: 'btn-default' } })

    raw "
    <div class='text-filter form-group'>
      <div class='input-label'>
        <label for='#{name}'>#{label}</label>
      </div>
      <div class='input-group'>
        #{text_field}
      </div>
    </div>
    ".html_safe
  end

  def date_range_filter(form, name, label, args = {})
    text_field_1 = form.text_field (name + '_gteq').to_sym, id: name, class: 'start-date form-control', value: filter_value(name + '_gteq')
    text_field_2 = form.text_field (name + '_lteq').to_sym, id: name, class: 'end-date form-control', value: filter_value(name + '_lteq')

    raw "
    <div class='date-range-filter form-group'>
      <div class='input-label'>
        <label for='#{name}'>#{label}</label>
      </div>
      <div class='input-group'>
        <div class='row'>
          <div class='col-md-6'>
            #{text_field_1}
          </div>
          <div class='col-md-6'>
            #{text_field_2}
          </div>
      </div>
      </div>
    </div>
    ".html_safe
  end

  def time_range_filter(form, name, label, args = {})
    html = ""

    html += "
        <div class='time-range-filter form-group'>
          <div class='row'>
            <div class='col-md-4'>
              <label for='#{name}'>#{label}</label>
            </div>
            <div class='col-md-4'>"

    html += form.text_field (name + '_gteq').to_sym, id: name, class: 'form-control', value: filter_value(name + '_gteq')

    html += "
           </div>
           <div class='col-md-4'>"

    html += form.text_field (name + '_lteq').to_sym, id: name, class: 'form-control', value: filter_value(name + '_lteq')

    html += "
            </div>
          </div>
        </div>"

    raw html.html_safe
  end

  def filter_value(name)
    if params[:q] && !params[:q][name.to_sym].blank?
      params[:q][name.to_sym]
    else
      nil
    end
  end

  # Takes options from I18n locale file with scope and makes options for select.
  # params:
  #
  # selected (string) - defines which option should be set as selected.
  # skip_values (array) - array of values which should be skipped from option list.
  def locale_options_to_select(scope, selected = nil, skip_values = nil)
    options_for_select(I18n.t(scope).map{|i| [i[1].to_s, i[0].to_s] if skip_values.nil? || skip_values.exclude?(i[0].to_s)}.compact, selected)
  end

  # Takes options from I18n locale file with scope and makes options filter select.
  def locale_options_for_filter(scope)
    I18n.t(scope).map{|i| [i[0].to_s, i[1].to_s]}
  end

end