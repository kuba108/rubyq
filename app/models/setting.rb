class Setting < ApplicationRecord

  after_commit do
    Setting.refresh(self.name)
  end

  def self.load_setting(name)
    Setting.find_by(name: name)
  end

  # Loads setting by its name and caches it.
  def self.load_value(name)
    Rails.cache.fetch("settings/#{name}", expires_in: 30.minutes) do
      setting = Setting.find_by(name: name)
      setting.present? ? setting.value : ""
    end
  end

  # Refreshes setting.
  # Can be used for testing or really necessary reasons,
  # otherwise setting will be refresh itself after expires_in time.
  def self.refresh(name)
    Rails.cache.delete("settings/#{name}")
    self.load_value(name)
  end

end
