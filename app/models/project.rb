class Project < ActiveRecord::Base
  has_many :time_entries
  validates :max_hours, :name, presence: true
  validates :name, uniqueness: true

  def total_hours
    all_hours = []
    time_entries.all.each do |t|
      all_hours << t.duration
    end
    all_hours.reduce(:+)
  end

  def maxed_out_time_budget?
    return true if total_hours > max_hours
  end
end
