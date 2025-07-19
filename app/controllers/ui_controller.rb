class UiController < ApplicationController
  Dir.entries('app/views/ui').map { |f| f.split('.')[0] }.compact.select { |f| !f.empty? }.each do |filename|
    define_method(filename) {}
  end

  # skip_before_action :require_user # Not needed for UI controller
  layout :choose_layout

  private
  def choose_layout
    case action_name
    when /^_/
      false
    else
      "application"
    end
  end
end
