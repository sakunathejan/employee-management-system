const API_BASE_URL = 'https://api.freeprojectapi.com';

const selectEmployeeDepartment = document.getElementById("departmentId");
const selectEmployeeDesignation = document.getElementById("designationId");
const btnAddEmployee = document.getElementById("btnSaveEmployee");
const btnUpdateEmployee = document.getElementById("btnUpdateEmployee");
const btnReset = document.getElementById("btnResetForm");

btnAddEmployee.addEventListener("click", addEmployee);
btnUpdateEmployee.addEventListener("click", updateEmployee);

btnReset.addEventListener("click", function () {
  btnUpdateEmployee.classList.add("hidden");
  btnAddEmployee.classList.remove("hidden");
});

// When department changes, load designations for that department
selectEmployeeDepartment.addEventListener("change", function () {
  loadDesignations(selectEmployeeDepartment.value);
});

// 1. Load Departments into dropdown
function loadDepartments() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetDepartments`)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Department --</option>';
      data.forEach(element => {
        options += `<option value="${element.departmentId}">${element.departmentName}</option>`;
      });
      selectEmployeeDepartment.innerHTML = options;
    });
}

// 2. Load Designations into dropdown
function loadDesignations(deptId, selectedDesignationId) {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetDesignationsByDeptId?deptId=${deptId}`)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Designation --</option>';
      data.forEach(element => {
        options += `<option value="${element.designationId}">${element.designationName}</option>`;
      });
      selectEmployeeDesignation.innerHTML = options;

      if (selectedDesignationId) {
        selectEmployeeDesignation.value = selectedDesignationId;
      }
    });
}

// 3. Add Employee (POST)
function addEmployee(event) {
  event.preventDefault();

  const fullName = document.getElementById("fullName").value;
  const email = document.getElementById("email").value;
  const phone = document.getElementById("phone").value;
  const gender = document.getElementById("gender").value;
  const departmentId = selectEmployeeDepartment.value;
  const designationId = selectEmployeeDesignation.value;
  const employeeType = document.getElementById("employeeType").value;
  const dateOfJoining = document.getElementById("dateOfJoining").value;
  const salary = document.getElementById("salary").value;

  const employee = {
    employeeId: 0,
    fullName: fullName,
    email: email,
    phone: phone,
    gender: gender,
    departmentId: Number(departmentId),
    designationId: Number(designationId),
    employeeType: employeeType,
    dateOfJoining: dateOfJoining,
    salary: Number(salary)
  };

  fetch(`${API_BASE_URL}/api/EmployeeApp/CreateEmployee`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(employee)
  })
    .then(res => res.json())
    .then(data => {
      console.log(data);
      alert("Employee Created!");
      document.getElementById("employeeForm").reset();
      loadEmployees();
    });
}

// 4. Edit Employee (fills the form when clicking "Edit" in the table)
function editEmployee(id) {
  fetch(`${API_BASE_URL}/api/EmployeeApp/${id}`)
    .then(res => res.json())
    .then(data => {
      document.getElementById("employeeId").value = data.employeeId;
      document.getElementById("fullName").value = data.fullName;
      document.getElementById("email").value = data.email;
      document.getElementById("phone").value = data.phone;
      document.getElementById("gender").value = data.gender;
      selectEmployeeDepartment.value = data.departmentId;
      document.getElementById("employeeType").value = data.employeeType;
      document.getElementById("dateOfJoining").value = data.dateOfJoining ? data.dateOfJoining.split("T")[0] : "";
      document.getElementById("salary").value = data.salary;

      // Load matching designations for this department and set the selected designation
      loadDesignations(data.departmentId, data.designationId);

      // Show Update button, hide Add button
      btnUpdateEmployee.classList.remove("hidden");
      btnAddEmployee.classList.add("hidden");
    });
}

// 5. Update Employee (PUT)
function updateEmployee() {
  const employeeId = document.getElementById("employeeId").value;
  const fullName = document.getElementById("fullName").value;
  const email = document.getElementById("email").value;
  const phone = document.getElementById("phone").value;
  const gender = document.getElementById("gender").value;
  const departmentId = selectEmployeeDepartment.value;
  const designationId = selectEmployeeDesignation.value;
  const employeeType = document.getElementById("employeeType").value;
  const dateOfJoining = document.getElementById("dateOfJoining").value;
  const salary = document.getElementById("salary").value;

  const employee = {
    employeeId: Number(employeeId),
    fullName: fullName,
    email: email,
    phone: phone,
    gender: gender,
    departmentId: Number(departmentId),
    designationId: Number(designationId),
    employeeType: employeeType,
    dateOfJoining: dateOfJoining,
    salary: Number(salary)
  };

  fetch(`${API_BASE_URL}/api/EmployeeApp/UpdateEmployee`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(employee)
  })
    .then(res => res.json())
    .then(data => {
      console.log(data);
      alert("Employee Updated!");
      document.getElementById("employeeForm").reset();
      btnUpdateEmployee.classList.add("hidden");
      btnAddEmployee.classList.remove("hidden");
      loadEmployees();
    });
}

// Function to delete an employee
function deleteEmployee(id) {
  if (confirm("Are you sure you want to delete this employee?")) {
    fetch(`${API_BASE_URL}/api/EmployeeApp/DeleteEmployee?id=${id}`, {
      method: "DELETE"
    })
      .then(res => {
        alert("Employee Deleted!");
        loadEmployees(); // Refresh the table
      });
  }
}

// 6. Load Employees to Table
function loadEmployees() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetEmployees`)
    .then(res => res.json())
    .then(data => {
      const totalEmployees = data.length;
      let tblItems = document.getElementById("employeeTableBody");
      let employeeCountBadge = document.getElementById("employeeCountBadge");
      let tblBody = "";
      let empCount =""

      data.forEach(element => {
        tblBody += `
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-${element.employeeId}</td>
            <td class="py-3 px-3 font-medium text-gray-900">${element.fullName}</td>
            <td class="py-3 px-3 text-xs">${element.email}</td>
            <td class="py-3 px-3 text-xs">${element.phone}</td>
            <td class="py-3 px-3 capitalize text-xs">${element.gender}</td>
            <td class="py-3 px-3">
              <span class="bg-purple-100 text-purple-800 text-xs px-2 py-0.5 rounded-full font-medium">
                ${element.departmentName}
              </span>
            </td>
            <td class="py-3 px-3 text-xs">${element.designationName}</td>
            <td class="py-3 px-3">
              <span class="bg-blue-100 text-blue-800 text-xs px-2 py-0.5 rounded-full font-medium">
                ${element.employeeType}
              </span>
            </td>
            <td class="py-3 px-3 text-xs">${element.dateOfJoining}</td>
            <td class="py-3 px-3 font-medium text-xs">Rs. ${element.salary}</td>
            <td class="py-3 px-3 text-center">
              <div class="inline-flex gap-1.5">
                <button type="button" onclick="editEmployee(${element.employeeId})" class="px-2 py-1 bg-amber-500 hover:bg-amber-600 text-white rounded text-xs">Edit</button>
                <button type="button" onclick="deleteEmployee(${element.employeeId})" class="px-2 py-1 bg-red-500 hover:bg-red-600 text-white rounded text-xs">Delete</button>
              </div>
            </td>
          </tr>
        `;
      });

      empCount += `
        <span id="employeeCountBadge" class="font-medium text-gray-700">Total Employees: ${totalEmployees}</span>
      `

      tblItems.innerHTML = tblBody;
      employeeCountBadge.innerHTML = empCount
    });
}

// Initial loads
loadDepartments();
loadEmployees();
