class Employee < ApplicationRecord
  belongs_to :department, optional: true

  validates :name, presence: true
  validates :age, numericality: { less_than_or_equal_to: 60, message: "cannot be greater than 60" }, allow_nil: true
  validates :ages, numericality: { less_than_or_equal_to: 60, message: "cannot be greater than 60" }, allow_nil: true

  def department_name
    department&.name || "Unassigned"
  end

  def email
    "#{name.to_s.downcase.parameterize(separator: '.')}@company.kh"
  end

  def phone
    "+855 12 #{sprintf('%03d', (id.to_i * 37) % 900 + 100)} #{sprintf('%03d', (id.to_i * 83) % 900 + 100)}"
  end

  def location
    "Phnom Penh"
  end

  def status
    "Active"
  end

  def join_date
    created_at&.strftime("%b %Y") || "Jan 2024"
  end

  def bio
    "Team member in #{department_name}. Passions & hobbies: #{hobbies.presence || 'Technology & Innovation'}."
  end

  def skills
    hobbies.to_s.split(",").map(&:strip).reject(&:blank?)
  end

  def avatar_color
    gradients = [
      "linear-gradient(135deg, #4f46e5, #7c3aed)",
      "linear-gradient(135deg, #06b6d4, #0284c7)",
      "linear-gradient(135deg, #10b981, #059669)",
      "linear-gradient(135deg, #f59e0b, #d97706)",
      "linear-gradient(135deg, #8b5cf6, #6d28d9)",
      "linear-gradient(135deg, #ec4899, #be185d)",
      "linear-gradient(135deg, #3b82f6, #1d4ed8)",
      "linear-gradient(135deg, #f43f5e, #e11d48)"
    ]
    gradients[(id || 0) % gradients.length]
  end

  # Allow hash-like access emp[:name], emp[:department], etc.
  def [](key)
    case key.to_sym
    when :department
      department_name
    when :department_name
      department_name
    when :email
      email
    when :phone
      phone
    when :location
      location
    when :status
      status
    when :join_date
      join_date
    when :bio
      bio
    when :skills
      skills
    when :avatar_color
      avatar_color
    else
      respond_to?(key) ? public_send(key) : super
    end
  end
end

