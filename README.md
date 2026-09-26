# SFIS Employee Directory & Management Web
> **Course / Program:** DPE Training & Testing (SFIS)  
> **Repository:** [sfis_project_book_employee_web](https://github.com/dalin-github/sfis_project_book_employee_web.git)

A full-stack Ruby on Rails application for managing employee profiles, departmental assignments, and workforce directory records using Docker and PostgreSQL.

---

## 📋 Table of Contents
1. [Quick Start (How to Run the Project)](#-quick-start-how-to-run-the-project)
2. [Technical Specifications](#-technical-specifications)
3. [Configuration & Environment](#-configuration--environment)
4. [Database Creation & Initialization](#-database-creation--initialization)
5. [Running the Test Suite](#-running-the-test-suite)
6. [Services & Architecture](#-services--architecture)
7. [Deployment Instructions](#-deployment-instructions)
8. [Debugging Guide & Common Gotchas](#-debugging-guide--common-gotchas)
9. [Lessons & Core Concepts Learned](#-lessons--core-concepts-learned)

---

## 🚀 Quick Start (How to Run the Project)

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running
- [Git](https://git-scm.com/)

### Step 1: Clone the Repository
```bash
git clone https://github.com/dalin-github/sfis_project_book_employee_web.git
cd sfis_project_book_employee_web
```

### Step 2: Start the Docker Containers
```bash
docker compose up --build
```
This builds and boots up:
- `employee_book_web`: Rails 8 application on port `3000`
- `employee_book_db`: PostgreSQL 10 database container

### Step 3: Open the Website
Open your browser and navigate to:
👉 **[http://localhost:3000](http://localhost:3000)**

---

## 🛠 Technical Specifications

- **Ruby Version:** `3.2.3` (specified in `.ruby-version` and Docker environment)
- **Rails Version:** `8.1.3+`
- **Database Engine:** PostgreSQL `10.0`
- **Asset Pipeline:** Propshaft, Importmap, Hotwire (Turbo & Stimulus)
- **Containerization:** Docker with Docker Compose

---

## ⚙️ Configuration & Environment

Environment settings are configured in `docker-compose.yml`:

| Variable | Value | Purpose |
| :--- | :--- | :--- |
| `RAILS_ENV` | `development` | Development environment with live reloading |
| `RAILS_MAX_THREADS` | `5` | Maximum thread pool size for Puma server |
| `DATABASE_URL` | `postgres://postgres:@db/employee_book` | Internal Docker connection string to PostgreSQL |
| `TZ` | `Asia/Phnom_Penh` | Database timezone |

---

## 🗄 Database Creation & Initialization

To initialize or reset the database with seed data:

### 1. Open a terminal inside the running container:
```bash
docker exec -it employee_book_web bash
```

### 2. Run Database Setup:
```bash
# Create database
bin/rails db:create

# Run pending migrations
bin/rails db:migrate

# Populate initial sample data
bin/rails db:seed
```

### Sample Seed Data Details:
- **Departments:** Engineering, Design, Product, HR, Operations, Marketing.
- **Employees:** Pre-seeded employee records with roles, departments, hobbies, and contact information.

---

## 🧪 Running the Test Suite

Run all automated unit and integration tests:

```bash
docker exec -it employee_book_web bin/rails test
```

To run a specific test:
```bash
docker exec -it employee_book_web bin/rails test test/models/employee_test.rb
```

---

## 🧩 Services & Architecture

- **Web Server (`web`):** Puma application server listening on `0.0.0.0:3000` mapped to host port `3000`.
- **Database (`db`):** PostgreSQL database service connected over internal Docker bridge network (`db`).
- **Health Check Endpoint:** `GET /up` for uptime monitoring and container status.

---

## 🚢 Deployment Instructions

### Production Docker Container:
```bash
# Build production image
docker build -t employee_book_web:latest -f Dockerfile .

# Run with production environment variables
docker run -e RAILS_ENV=production -e DATABASE_URL=postgres://user:pass@host/db -p 3000:3000 employee_book_web:latest
```

### Kamal Deployment:
The project is configured for automated deployments with Kamal via `.kamal/` and `config/deploy.yml`:
```bash
bin/kamal setup
bin/kamal deploy
```

---

## 🐞 Debugging Guide & Common Gotchas

### 1. Always Run `reload!` in the Rails Console
**Problem:** You edited `app/models/employee.rb`, but in `bin/rails c`, changes to validations or callbacks are not working.  
**Cause:** The Rails console caches Ruby classes in RAM upon boot.  
**Fix:** Run `reload!` inside the console after every file modification:
```ruby
sfis-training-testing(dev):001> reload!
Reloading...
=> true
```

### 2. `NameError: undefined local variable or method 'employee'`
**Problem:** Typing `employee.errors.full_messages` throws `NameError`.  
**Cause:** The variable `employee` has not been assigned in your current console session.  
**Fix:** Assign it first:
```ruby
employee = Employee.first
# or
employee = Employee.new(name: "Rosa", age: 65)
```

### 3. Do Not Paste the `=>` Prompt Symbol
**Problem:** `SyntaxError: unexpected =>` in terminal.  
**Cause:** `=>` is the output returned by IRB; do not copy/paste lines containing `=>`.

### 4. Database Column Discrepancy (`age` vs `ages`)
**Notice:** The database schema has both `age` and `ages`. In controllers and seeds, `ages` is permitted. Ensure validations match the attribute you are assigning.

---

## 🎓 Lessons & Core Concepts Learned

### Lesson 1: Active Record Validations
- Using `validates :attribute, presence: true` to prevent blank values.
- Using `numericality: { greater_than_or_equal_to: 60 }` to enforce numerical business constraints.
- Inspecting validation status via `.valid?` and reading error messages using `.errors.full_messages`.

### Lesson 2: Active Record Callbacks & Lifecycle
- Hooking into the model persistence lifecycle using `before_save` and `after_save`.
- Understanding execution flow:
  1. Trigger `.save`
  2. Runs validations (if fails, halts immediately)
  3. Executes `before_save` callbacks (`my_first_test`)
  4. Commits SQL transaction to PostgreSQL (`INSERT INTO / UPDATE`)
  5. Executes `after_save` callbacks (`my_second_test`)

### Lesson 3: Rails Console (`IRB`) Interactive Testing
- Testing model logic without needing to click through web forms.
- Re-initializing and querying models (`Employee.find_by`, `Employee.new`).

### Lesson 4: Dockerized Rails Development
- Running containerized multi-service applications using `docker-compose.yml`.
- Executing administrative and debugging commands in a running container via `docker exec -it <container_name> bash`.
