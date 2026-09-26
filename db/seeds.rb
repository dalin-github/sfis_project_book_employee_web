# Seed Departments
departments = [
  "Engineering",
  "Design",
  "Product",
  "HR",
  "Operations",
  "Marketing"
].map do |name|
  Department.find_or_create_by!(name: name)
end

dept_map = departments.index_by(&:name)

# Seed Employees
sample_employees = [
  {
    name: "Sophal Meas",
    ages: 32,
    role: "Lead Systems Architect",
    gender: "Male",
    hobbies: "Ruby on Rails, PostgreSQL, Docker, AWS, Kubernetes",
    department: dept_map["Engineering"]
  },
  {
    name: "Dany Chhorn",
    ages: 28,
    role: "Senior Product Designer",
    gender: "Female",
    hobbies: "Figma, Design Systems, User Research, Prototyping",
    department: dept_map["Design"]
  },
  {
    name: "Vireak Botum",
    ages: 26,
    role: "Full Stack Developer",
    gender: "Male",
    hobbies: "React, Ruby, TypeScript, Tailwind CSS",
    department: dept_map["Engineering"]
  },
  {
    name: "Kalyan Srey",
    ages: 35,
    role: "HR Operations Director",
    gender: "Female",
    hobbies: "Talent Acquisition, People Ops, Culture, Compensation",
    department: dept_map["HR"]
  },
  {
    name: "Rithy Seng",
    ages: 30,
    role: "DevOps & Infrastructure",
    gender: "Male",
    hobbies: "CI/CD, Terraform, Monitoring, Linux, Security",
    department: dept_map["Operations"]
  },
  {
    name: "Channa Heng",
    ages: 33,
    role: "Principal Product Manager",
    gender: "Female",
    hobbies: "Product Strategy, Roadmapping, Agile/Scrum, Data Analytics",
    department: dept_map["Product"]
  }
]

sample_employees.each do |emp_attrs|
  Employee.find_or_create_by!(name: emp_attrs[:name]) do |emp|
    emp.ages = emp_attrs[:ages]
    emp.role = emp_attrs[:role]
    emp.gender = emp_attrs[:gender]
    emp.hobbies = emp_attrs[:hobbies]
    emp.department = emp_attrs[:department]
  end
end

