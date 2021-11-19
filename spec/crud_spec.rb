require "spec_helper"
require "panko"
require "panko/crud"

RSpec.describe Panko::Crud, "#build" do
  let(:item_class) do
    Class.new do
      def to_s
        "Item 123"
      end
    end
  end

  let(:item_breadcrumbs_class) do
    Class.new(Panko::Crud)
  end

  before do
    stub_const("Item", item_class)
    stub_const("ItemBreadcrumbs", item_breadcrumbs_class)
    expect_i18n "layout.breadcrumb_root" => "My root",
                "items.index.title"      => "Items"

    allow(controller).to receive(:root_path).and_return("/")
    expect_url_for [ Item ] => "/items"
  end

  context "in controller #index" do
    let(:controller) { double(action_name: "index") }

    it "builds an index breadcrumb" do
      expect_to_add_breadcrumb("My root", "/")
      expect_to_add_breadcrumb("Items", "/items")

      ItemBreadcrumbs.new(controller, nil).build
    end
  end

  context "in controller #show" do
    let(:controller) { double(action_name: "show") }
    let(:item) { Item.new }

    before do
      expect_url_for [ item ] => "/items/123"
    end

    it "builds a show breadcrumb" do
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
