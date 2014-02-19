require "attr_extras"
require "i18n"
require "active_support/all"

class Panko::Base
  pattr_initialize :controller

  def build
    add_root
  end

  private

  def add_root
    add_breadcrumb t("layout.breadcrumb_root"), root_path
  end

  def t(*opts)
    I18n.t(*opts)
  end

  # Delegate *_path to the controller.
  def method_missing(name, *args)
    if name.to_s.end_with?("_path")
      controller.public_send(name, *args)
    else
      super
    end
  end

  private

  delegate :add_breadcrumb, :url_for,
    to: :controller
end
