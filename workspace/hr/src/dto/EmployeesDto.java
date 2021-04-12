package dto;

import java.sql.Date;

public class EmployeesDto {

	// field (칼럼명 snake case -> 필드명 camel case)
	// employees 테이블
	
	private int employeeId;   // EMPLOYEE_ID NUMBER(6)
	private String firstName;
	private String last_Name;
	private String email;
	private String phoneNumber;
	private Date hire_Date;
	private String jobId;
	private double salary;   // SALARY NUMBER(8,2)
	private double commissionPct;   // COMMIISION_PCT NUMBER(2,2)
	private int managerId;
	private int department_ID;
	
	// constructor
	public EmployeesDto() {}

	public EmployeesDto(int employeeId, String firstName, String last_Name, String email, String phoneNumber,
			Date hire_Date, String jobId, double salary, double commissionPct, int managerId, int department_ID) {
		super();
		this.employeeId = employeeId;
		this.firstName = firstName;
		this.last_Name = last_Name;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.hire_Date = hire_Date;
		this.jobId = jobId;
		this.salary = salary;
		this.commissionPct = commissionPct;
		this.managerId = managerId;
		this.department_ID = department_ID;
	}

	// departments 테이블
	private String departmentName;  // DEPARTMENT_ID
	
	
	// method
	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLast_Name() {
		return last_Name;
	}

	public void setLast_Name(String last_Name) {
		this.last_Name = last_Name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Date getHire_Date() {
		return hire_Date;
	}

	public void setHire_Date(Date hire_Date) {
		this.hire_Date = hire_Date;
	}

	public String getJobId() {
		return jobId;
	}

	public void setJobId(String jobId) {
		this.jobId = jobId;
	}

	public double getSalary() {
		return salary;
	}

	public void setSalary(double salary) {
		this.salary = salary;
	}

	public double getCommissionPct() {
		return commissionPct;
	}

	public void setCommissionPct(double commissionPct) {
		this.commissionPct = commissionPct;
	}

	public int getManagerId() {
		return managerId;
	}

	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}

	public int getDepartment_ID() {
		return department_ID;
	}

	public void setDepartment_ID(int department_ID) {
		this.department_ID = department_ID;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	@Override
	public String toString() {
		return "EmployeesDto [firstName=" + firstName + ", last_Name=" + last_Name + ", hire_Date=" + hire_Date
				+ ", salary=" + salary + ", departmentName=" + departmentName + "]";
	}

	
	
	

	
	
	
	
	
}
