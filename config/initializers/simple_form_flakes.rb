# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # config.error_notification_class = 'alert alert-danger'
  # config.button_class = 'btn btn-default'
  # config.boolean_label_class = nil

  config.wrappers :vertical_form, :tag => 'li' do |b|
    b.use :html5

    b.use :label
    b.use :input
  end

end
