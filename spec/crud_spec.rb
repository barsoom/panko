require "spec_helper"
require "panko/crud"

class Item
  def to_s
    "Item 123"
  end
end

class ItemBreadcrumbs < Panko::Crud
end

describe Panko::Crud, "#build" do
  let(:controller) { double(:controller, action_name: action_name, root_path: "/") }

  context "in controller #index" do
    let(:action_name) { "index" }

    it "builds an index breadcrumb" do
      expect_i18n "layout.breadcrumb_root" => "My root",
                  "items.index.title"      => "Items"

      expect_url_for [ Item ] => "/items"

      expect_to_add_breadcrumb("My root", "/")
      expect_to_add_breadcrumb("Items", "/items")

      ItemBreadcrumbs.new(controller, nil).build
    end
  end

  context "in controller #show" do
    let(:action_name) { "show" }
    let(:item) { Item.new }

    it "builds a show breadcrumb" do
      expect_i18n "layout.breadcrumb_root" => "My root",
                  "items.index.title"      => "Items"

      expect_url_for [ Item ] => "/items",
                     [ item ] => "/items/123"

      expect_to_add_breadcrumb("My root", "/")
      expect_to_add_breadcrumb("Items", "/items")
      expect_to_add_breadcrumb("Item 123", "/items/123")

      ItemBreadcrumbs.new(controller, item).build
    end
  end

  private

  def expect_i18n(hash)
    hash.each do |key, value|
      expect(I18n).to receive(:t).with(key).and_return(value)
    end
  end

  def expect_url_for(hash)
    hash.each do |args, value|
      expect(controller).to receive(:url_for).with(args).and_return(value)
    end
  end

  def expect_to_add_breadcrumb(name, path)
    expect(controller).to receive(:add_breadcrumb).with(name, path)
  end
end
