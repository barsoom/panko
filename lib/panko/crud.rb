require "panko/base"

class Panko::Crud < Panko::Base
  pattr_initialize :controller, :persisted_record

  def build
    super
    add_index
    add_show
    add_new_or_edit
  end

  private

  def record_class
    # E.g. "EmployeesBreadcrumbs" -> Employee.
    self.class.name.sub(/Breadcrumbs$/, "").
      singularize.constantize
  end

  def add_index
    add_breadcrumb t("#{t_scope}.index.title"), index_path
  end

  def add_show
    if persisted_record
      add_breadcrumb persisted_record.to_s, show_path
    end
  end

  def add_new_or_edit
    if new?
      add_breadcrumb t("#{t_scope}.new.title"), nil
    elsif edit?
      add_breadcrumb t("#{t_scope}.edit.title"), nil
    end
  end

  def t_scope
    # E.g. "employees".
    record_class.name.tableize
  end

  def index_path
    url_for(index_context)
  end

  def show_path
    url_for(show_context)
  end

  def index_context
    [ record_class ]
  end

  def show_context
    [ persisted_record ]
  end

  def edit?
    %w[edit update].include?(controller.action_name)
  end

  def new?
    %w[new create].include?(controller.action_name)
  end
end
