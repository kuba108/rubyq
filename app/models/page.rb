class Page < ApplicationRecord

  belongs_to :admin_user
  has_many :routes, as: :routable, dependent: :destroy
  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :routes

  def self.home_page
    Page.find_by(home_page: true)
  end

  def route
    routes.detect { |r| r.route_type == 'standard' }
  end

  def layout
    self[:layout] || 'default'
  end

  def page_locales
    Page.where(uuid: self.uuid).where.not(id: self.id)
  end

  def has_locales?
    self.page_locales.any?
  end

  def permalink
    route.permalink if route
  end

  def title
    self[:title] || Setting.load_value(:title)
  end

  def meta_title
    self[:meta_title] || Setting.load_value(:meta_title)
  end

  def meta_description
    self[:meta_description] || Setting.load_value(:meta_description)
  end

  def meta_keywords
    self[:meta_keywords] || Setting.load_value(:meta_keywords)
  end

  def meta_robots
    self[:meta_robots] || Setting.load_value(:meta_robots)
  end

  def og_title
    self[:og_title] || Setting.load_value(:og_title)
  end

  def og_description
    self[:og_description] || Setting.load_value(:og_description)
  end

  def og_url
    self[:og_url] || Setting.load_value(:og_url)
  end

  def og_image
    self[:og_image] || Setting.load_value(:og_image)
  end

end
