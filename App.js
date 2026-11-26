const API_BASE_URL = 'https://api.freeprojectapi.com';

const selectEmployeeDepartment = document.getElementById("departmentId");
const selectEmployeeDesignation = document.getElementById("designationId");
const btnAddEmployee = document.getElementById("btnSaveEmployee");

btnAddEmployee.addEventListener("click", addEmployee);

selectEmployeeDepartment.addEventListener("change", function () {
  loadDesignations(selectEmployeeDepartment.value);
});

function loadDepartments() {
  fetch(${API_BASE_URL}/api/EmployeeApp/GetDepartments)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Department --</option>';
      data.forEach(element => {
        options += <option value=""></option>;
      });
      selectEmployeeDepartment.innerHTML = options;
    });
}

function loadDesignations(deptId) {
  fetch(${API_BASE_URL}/api/EmployeeApp/GetDesignationsByDeptId?deptId=)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Designation --</option>';
      data.forEach(element => {
        options += <option value=""></option>;
      });
      selectEmployeeDesignation.innerHTML = options;
    });
}

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

  fetch(${API_BASE_URL}/api/EmployeeApp/CreateEmployee, {
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

function loadEmployees() {
  fetch(${API_BASE_URL}/api/EmployeeApp/GetEmployees)
    .then(res => res.json())
    .then(data => {
      let tblItems = document.getElementById("employeeTableBody");
      let tblBody = "";
      data.forEach(element => {
        tblBody += 
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-</td>
            <td class="py-3 px-3 font-medium text-gray-900"></td>
            <td class="py-3 px-3 text-xs"></td>
            <td class="py-3 px-3 text-xs"></td>
            <td class="py-3 px-3 capitalize text-xs"></td>
            <td class="py-3 px-3"><span class="bg-purple-100 text-purple-800 text-xs px-2 py-0.5 rounded-full font-medium"></span></td>
            <td class="py-3 px-3 text-xs"></td>
            <td class="py-3 px-3"><span class="bg-blue-100 text-blue-800 text-xs px-2 py-0.5 rounded-full font-medium"></span></td>
            <td class="py-3 px-3 text-xs"></td>
            <td class="py-3 px-3 font-medium text-xs">Rs. </td>
            <td class="py-3 px-3 text-center">
              <button type="button" class="px-2 py-1 bg-amber-500 text-white rounded text-xs">Edit</button>
              <button type="button" class="px-2 py-1 bg-red-500 text-white rounded text-xs">Delete</button>
            </td>
          </tr>
        ;
      });
      tblItems.innerHTML = tblBody;
    });
}

loadDepartments();
loadEmployees();
