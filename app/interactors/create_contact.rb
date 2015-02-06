require 'interactor_creator'
require 'interactor_localized'

# Create a new +Contact+
class CreateContact
  include Interactor
  include Interactor::Creator
  include Interactor::Localized

  delegate :entity, :to => :context
  delegate :contact, :to => :context
  delegate :user, :to => :context

  def call
    entity.whodunnit(user) { persist! }

    context.message =
      t('ar.success.messages.updated', :model => t('ar.models.contact'))
  end

  protected

  def after_build
    contact.display_name =
      [
        contact.title, contact.first_name, contact.last_name
      ]
      .reject(&:blank?)
      .join(' ')
  end

  def base_params
    context
      .to_h
      .slice(:first_name,
             :last_name,
             :display_name,
             :title,
             :email_address,
             :fax_number,
             :mobile_number,
             :phone_number)
  end

  def build_params
    base_params
      .merge(:uuid => UUID.generate(:compact))
      .merge(:entity => entity)
  end

  def persist!
    contact.save!
  end

  def validate
    return if contact.valid?

    context.fail!(:message => 'Invalid details')
  end
end
