# EntitiesHelper
module EntitiesHelper
  def active_string(object)
    object.active? ? 'Active' : 'Inactive'
  end

  def customer_block(entity)
    if entity.customer
      render :partial => '/entities/customer/detail',
             :locals => { :customer => entity.customer }
    else
      render :partial => '/entities/customer/empty'
    end
  end

  def entity_customer_nav(entity, return_url)
    link_options = { :class => 'button' }
    content_tag :nav do
      safe_join(
        [
          customer_link(entity, return_url, link_options),
          ' ',
          versions_link('customer', entity.customer, return_url, link_options)
        ]
      )
    end
  end

  def entity_block(options, &block)
    wrapper_html = options[:wrapper_html] || {}
    wrapper_html = inject_classes(wrapper_html, %w(disabled)) \
      if options[:disabled]

    content = capture(&block)

    content_tag(:div, content, wrapper_html)
  end

  def edit_entity_link(entity, return_url, options)
    link_to 'Edit',
            edit_entity_path(entity, :return_url => return_url),
            options
  end

  def location_string(entity)
    return nil if entity.location.nil?

    entity.location.decorate.long_address
  end

  def customer_link(entity, return_url, options)
    if entity.customer
      edit_customer_link(entity.customer, return_url, options)
    else
      new_customer_link(entity, return_url, options)
    end
  end

  def salesperson_link(entity, return_url, options)
    if entity.salesperson
      edit_salesperson_link(entity.salesperson, return_url, options)
    else
      new_salesperson_link(entity, return_url, options)
    end
  end

  def edit_customer_link(customer, return_url, options)
    link_to 'Edit',
            edit_customer_path(
              customer,
              :return_url => return_url),
            options
  end

  def new_customer_link(entity, return_url, options)
    link_to 'New',
            new_entity_customer_path(entity, :return_url => return_url),
            options
  end

  def edit_salesperson_link(salesperson, return_url, options)
    link_to 'Edit',
            edit_salesperson_path(
              salesperson,
              :return_url => return_url),
            options
  end

  def new_salesperson_link(entity, return_url, options)
    link_to 'New',
            new_entity_salesperson_path(entity, :return_url => return_url),
            options
  end

  protected

  # Merge classes from an array into an existing html class string.
  #
  # @param [String] class_string the class string to merge into
  # @param [Array] classes an array of css classes to merge
  def merge_classes(class_string, classes)
    class_string
      .split(' ')
      .concat(classes)
      .uniq
      .join(' ')
  end

  # Injects classes into an html attribute hash.
  #
  # @param [Hash] html a hash of html attributes to inject classes into
  # @param [Array] classes an array of css classes to merge
  def inject_classes(html = {}, classes)
    class_string = merge_classes(html[:class] || '', classes)

    new_html = html.dup
    new_html[:class] = class_string unless class_string.blank?
    new_html
  end
end
