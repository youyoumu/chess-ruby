# frozen_string_literal: true

class String
  def light
    "\e[48;5;250m#{self}\e[0m"
  end

  def dark
    "\e[48;5;33m#{self}\e[0m"
  end
end
