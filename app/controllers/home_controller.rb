class HomeController < ApplicationController
  def index
    @employees = [
      { id: 1, name: "Sophal Meas", role: "Lead Systems Architect", department: "Engineering", email: "sophal.m@company.kh", status: "Active", location: "Phnom Penh", avatar_color: "#4f46e5" },
      { id: 2, name: "Dany Chhorn", role: "Senior Product Designer", department: "Design", email: "dany.c@company.kh", status: "Active", location: "Remote", avatar_color: "#06b6d4" },
      { id: 3, name: "Vireak Botum", role: "Full Stack Developer", department: "Engineering", email: "vireak.b@company.kh", status: "Active", location: "Phnom Penh", avatar_color: "#10b981" },
      { id: 4, name: "Kalyan Srey", role: "HR Operations Director", department: "HR", email: "kalyan.s@company.kh", status: "On Leave", location: "Phnom Penh", avatar_color: "#f59e0b" },
      { id: 5, name: "Rithy Seng", role: "DevOps & Infrastructure", department: "Operations", email: "rithy.s@company.kh", status: "Active", location: "Remote", avatar_color: "#8b5cf6" },
      { id: 6, name: "Channa Heng", role: "Product Manager", department: "Product", email: "channa.h@company.kh", status: "Active", location: "Phnom Penh", avatar_color: "#ec4899" }
    ]
  end
end
