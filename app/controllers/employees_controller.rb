class EmployeesController < ApplicationController
  def index
    @departments = Department.order(:name)
    @employees = Employee.includes(:department).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json do
        render json: @employees.as_json(
          include: { department: { only: [:id, :name] } },
          methods: [:department_name, :email, :phone, :location, :status, :join_date, :skills, :bio, :avatar_color]
        )
      end
    end
  end

  def new
    @departments = Department.order(:name)
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      respond_to do |format|
        format.html { redirect_to employees_path, notice: "Employee '#{@employee.name}' created successfully!" }
        format.json { render json: @employee, status: :created }
      end
    else
      @departments = Department.order(:name)
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee = Employee.find_by(id: params[:id])
    if @employee
      @employee.destroy
      respond_to do |format|
        format.html { redirect_to employees_path, notice: "Employee was successfully deleted." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to employees_path, alert: "Employee not found." }
        format.json { render json: { error: "Not found" }, status: :not_found }
      end
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :ages, :role, :gender, :hobbies, :department_id)
  rescue ActionController::ParameterMissing
    params.permit(:name, :ages, :role, :gender, :hobbies, :department_id)
  end
end


