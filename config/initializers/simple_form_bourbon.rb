# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :basic_form, :tag => 'p', :class => 'field' do |b|
    b.use :html5

    b.use :label
    b.use :input
  end

  # config.wrappers :checkbox, :tag => 'div', :class => 'inline field' do |b|
  #   b.wrapper :tag => 'div', :class => 'ui checkbox' do |component|
  #     component.use :input
  #     component.use :label
  #   end
  # end

  config.label_text = -> label, _required, _explicit_label { "#{label}" }
end
