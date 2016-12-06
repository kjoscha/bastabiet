class Setting < ActiveRecord::Base
  def self.add_default
    Setting.create(needed_sum: 15_000)
  end
end
