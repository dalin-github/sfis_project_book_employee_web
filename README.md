# SFIS Employee Directory & Management Web

A modern Ruby on Rails web application for managing employees, departmental rosters, contacts, and workforce statistics.

---

## 📋 Table of Contents
- [Overview](#overview)
- [Tech Stack & Ruby Version](#tech-stack--ruby-version)
- [System Dependencies](#system-dependencies)
- [Configuration & Environment](#configuration--environment)
- [Setup & Running with Docker (Recommended)](#setup--running-with-docker-recommended)
- [Database Setup & Initialization](#database-setup--initialization)
- [Running the Rails Console](#running-the-rails-console)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
- [Services & Architecture](#services--architecture)
- [Deployment Instructions](#deployment-instructions)

---

## 🔍 Overview
SFIS Employee Directory provides:
- Employee Directory with live search, filters (department, role), and pagination.
- Departmental groupings and assignment management.
- Employee profile modals with contact details, skills, and status tracking.
- Interactive analytics dashboard (headcount, department breakdown).

---

## 🛠 Tech Stack & Ruby Version
- **Ruby:** `3.2.3` (defined in `.ruby-version` and Docker containers)
- **Rails:** `8.1.x`
- **Database:** PostgreSQL `10.0+`
- **Frontend / Assets:** Propshaft, Hotwire (Turbo & Stimulus), Importmaps, Vanilla CSS Design System
- **Containerization:** Docker & Docker Compose

---

## 💻 System Dependencies
If running **locally with Docker** (Recommended):
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)
- Git

If running **natively without Docker**:
- Ruby 3.2.3 (via `rbenv`, `rvm`, or `asdf`)
- PostgreSQL client libraries (`libpq-dev` / `postgresql`)
- Bundler (`gem install bundler`)

---

## ⚙️ Configuration & Environment
The app uses Docker environment configurations in `docker-compose.yml`:

| Environment Variable | Default Value | Description |
| :--- | :--- | :--- |
| `RAILS_ENV` | `development` | Rails operating environment |
| `RAILS_MAX_THREADS` | `5` | Puma worker thread count |
| `DATABASE_URL` | `postgres://postgres:@db/employee_book` | PostgreSQL connection string |
| `TZ` | `Asia/Phnom_Penh` | Database container timezone |

---

## 🚀 Setup & Running with Docker (Recommended)

### 1. Clone the repository
```bash
git clone https://github.com/dalin-github/sfis_project_book_employee_web.git
cd sfis_project_book_employee_web
```

### 2. Build and launch the containers
```bash
docker compose up --build
```
The application will be accessible at **[http://localhost:3000](http://localhost:3000)**.

---

## 🗄 Database Setup & Initialization

### Create database, run migrations, and load sample seed data:
Open a new terminal tab and run inside the web container:

```bash
# Enter the web container
docker exec -it employee_book_web bash

# Inside the container:
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### Sample Seed Data includes:
- Standard departments: *Engineering, Design, Product, HR, Operations, Marketing*.
- Pre-populated employee profiles with roles, departments, hobbies, and contact information.

---

## 🖥 Running the Rails Console
To interact with models (`Employee`, `Department`) via IRB:

```bash
docker exec -it employee_book_web bin/rails console
```

Example usage:
```ruby
# Query records
Employee.all
Employee.where(department_id: 1)

# Check model validations and callbacks
emp = Employee.new(name: "Rosa", age: 65)
emp.valid?
emp.save
```

---

## 🧪 How to Run the Test Suite

Run unit and integration tests using Rails test runner inside the container:

```bash
docker exec -it employee_book_web bin/rails test
```

To run a specific test file:
```bash
docker exec -it employee_book_web bin/rails test test/models/employee_test.rb
```

---

## 🧩 Services & Architecture
- **Web Service (`web`):** Rails server running on Puma listening on port `3000:3000`.
- **Database Service (`db`):** PostgreSQL container storing data in a mounted volume.
- **Asset Pipeline:** Rails Propshaft with Stimulus controllers loaded via importmaps (`app/javascript/controllers`).
- **Health Check Endpoint:** `GET /up` returns HTTP 200 when the app and database are healthy.

---

## 🚢 Deployment Instructions

### Using Docker / Production Container:
1. Build the production Docker image using the root `Dockerfile`:
   ```bash
   docker build -t sfis_employee_web:latest .
   ```
2. Set the required production environment variables:
   - `RAILS_MASTER_KEY` (or `SECRET_KEY_BASE`)
   - `DATABASE_URL` (points to production PostgreSQL)
   - `RAILS_ENV=production`

### Using Kamal:
The application includes Kamal configuration for deployment (`.kamal/` and `config/deploy.yml`):
```bash
bin/kamal setup
bin/kamal deploy
```
