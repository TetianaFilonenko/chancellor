# TypeaheadInput
class TypeaheadInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.content_tag(:p, :class => 'typeahead-inputs') do
      template.concat value_field
      template.concat typeahead_field
      template.concat button
    end
  end

  def button
    template.content_tag(:button, :class => 'clear', :type => 'button') do
      remove_icon
    end
  end

  def remove_icon
    template.content_tag(:i, :class => 'fa fa-remove') {}
  end

  def typeahead_field
    @builder.text_field(attribute_name.to_s + '_typeahead')
  end

  def value_field
    @builder.hidden_field(attribute_name)
  end
end
