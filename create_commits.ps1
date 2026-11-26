# Script to build progressive git commits
$backupDir = "$env:TEMP\employee_app_final_backup"

# 1. Initialize git
git init
git branch -M main

# Set remote origin
git remote remove origin 2>$null
git remote add origin https://github.com/sakunathejan/employee-management-system.git

# Function to commit with a date
function Make-Commit($msg, $dateStr) {
    git add -A
    $env:GIT_AUTHOR_DATE = $dateStr
    $env:GIT_COMMITTER_DATE = $dateStr
    git commit -m $msg
    Remove-Item Env:\GIT_AUTHOR_DATE
    Remove-Item Env:\GIT_COMMITTER_DATE
}

# --- COMMIT 1: Initial commit ---
@"
# Employee Management System
Lightweight employee management web application built with HTML, Tailwind CSS, and Vanilla JavaScript, supporting full CRUD operations with Department and Designation lookups.
"@ | Set-Content -Path "README.md"

@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Management System</title>
</head>
<body>
  <h1>Employee Management System</h1>
  <script src="App.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

"// App.js - Application Entry Point" | Set-Content -Path "App.js"

Make-Commit "Initial commit: project structure and HTML skeleton" "2026-11-26 12:15:00 +0530"

# --- COMMIT 2: Tailwind CDN & Navbar ---
@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Management System</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen text-gray-800 font-sans">
  <header class="bg-blue-600 text-white shadow-md">
    <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row justify-between items-center gap-2">
      <div>
        <h1 class="text-2xl font-bold tracking-wide">Employee Management System</h1>
        <p class="text-xs text-blue-100">Simple CRUD Operations with Department & Designation Lookup</p>
      </div>
      <div class="text-sm bg-blue-700 px-3 py-1.5 rounded-lg text-blue-100">
        Status: <span class="text-white font-medium">Ready</span>
      </div>
    </div>
  </header>
  <main class="max-w-7xl mx-auto px-4 py-6 space-y-6">
  </main>
  <script src="App.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

Make-Commit "feat(ui): add Tailwind CSS CDN and header navbar" "2026-11-26 12:35:00 +0530"

# --- COMMIT 3: Employee Form Layout ---
@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Management System</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen text-gray-800 font-sans">
  <header class="bg-blue-600 text-white shadow-md">
    <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row justify-between items-center gap-2">
      <div>
        <h1 class="text-2xl font-bold tracking-wide">Employee Management System</h1>
        <p class="text-xs text-blue-100">Simple CRUD Operations with Department & Designation Lookup</p>
      </div>
      <div class="text-sm bg-blue-700 px-3 py-1.5 rounded-lg text-blue-100">
        Status: <span class="text-white font-medium">Ready</span>
      </div>
    </div>
  </header>
  <main class="max-w-7xl mx-auto px-4 py-6 space-y-6">
    <section class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
      <div class="border-b pb-3 mb-4 flex justify-between items-center">
        <h2 class="text-lg font-semibold text-gray-800 flex items-center gap-2">
          <span>👤</span> Employee Details Form
        </h2>
        <span class="text-xs text-gray-400">Fill details to save/update</span>
      </div>
      <form id="employeeForm" class="space-y-4">
        <input type="hidden" id="employeeId" value="0">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div class="sm:col-span-2">
            <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
            <input type="text" id="fullName" placeholder="e.g. John Doe" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
            <input type="email" id="email" placeholder="john@company.com" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
          <div>
            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone Number *</label>
            <input type="tel" id="phone" placeholder="e.g. 0771234567" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
        </div>
        <div class="pt-3 border-t flex flex-wrap gap-3">
          <button type="submit" id="btnSaveEmployee" class="px-5 py-2 bg-blue-600 text-white font-medium text-sm rounded-lg">Add Employee</button>
          <button type="reset" id="btnResetForm" class="px-5 py-2 bg-gray-200 text-gray-700 font-medium text-sm rounded-lg">Clear</button>
        </div>
      </form>
    </section>
  </main>
  <script src="App.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

Make-Commit "feat(ui): build employee registration form layout" "2026-11-26 12:55:00 +0530"

# --- COMMIT 4: Employee Directory Table ---
@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Management System</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen text-gray-800 font-sans">
  <header class="bg-blue-600 text-white shadow-md">
    <div class="max-w-7xl mx-auto px-4 py-4 flex flex-col sm:flex-row justify-between items-center gap-2">
      <div>
        <h1 class="text-2xl font-bold tracking-wide">Employee Management System</h1>
        <p class="text-xs text-blue-100">Simple CRUD Operations with Department & Designation Lookup</p>
      </div>
      <div class="text-sm bg-blue-700 px-3 py-1.5 rounded-lg text-blue-100">
        Status: <span class="text-white font-medium">Ready</span>
      </div>
    </div>
  </header>
  <main class="max-w-7xl mx-auto px-4 py-6 space-y-6">
    <section class="bg-white p-6 rounded-xl shadow-sm border border-gray-200">
      <div class="border-b pb-3 mb-4 flex justify-between items-center">
        <h2 class="text-lg font-semibold text-gray-800 flex items-center gap-2">
          <span>👤</span> Employee Details Form
        </h2>
      </div>
      <form id="employeeForm" class="space-y-4">
        <input type="hidden" id="employeeId" value="0">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div class="sm:col-span-2">
            <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
            <input type="text" id="fullName" placeholder="e.g. John Doe" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
            <input type="email" id="email" placeholder="john@company.com" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
          <div>
            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone Number *</label>
            <input type="tel" id="phone" placeholder="e.g. 0771234567" class="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm" required>
          </div>
        </div>
        <div class="pt-3 border-t flex flex-wrap gap-3">
          <button type="submit" id="btnSaveEmployee" class="px-5 py-2 bg-blue-600 text-white font-medium text-sm rounded-lg">Add Employee</button>
          <button type="reset" id="btnResetForm" class="px-5 py-2 bg-gray-200 text-gray-700 font-medium text-sm rounded-lg">Clear</button>
        </div>
      </form>
    </section>
    <section class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
      <div class="p-4 border-b border-gray-200 flex justify-between items-center">
        <h2 class="text-lg font-semibold text-gray-800">Employee Directory</h2>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse text-sm">
          <thead class="bg-gray-50 border-b border-gray-200 text-xs font-semibold text-gray-600 uppercase">
            <tr>
              <th class="py-3 px-3"># ID</th>
              <th class="py-3 px-3">Name</th>
              <th class="py-3 px-3">Email</th>
              <th class="py-3 px-3">Phone</th>
              <th class="py-3 px-3 text-center">Actions</th>
            </tr>
          </thead>
          <tbody id="employeeTableBody" class="divide-y divide-gray-100 text-gray-700">
          </tbody>
        </table>
      </div>
    </section>
  </main>
  <script src="App.js"></script>
</body>
</html>
"@ | Set-Content -Path "index.html"

Make-Commit "feat(ui): design employee directory table with action headers" "2026-11-26 13:15:00 +0530"

# --- COMMIT 5: App.js Setup & API Base URL ---
@"
const API_BASE_URL = 'https://api.freeprojectapi.com';

console.log("App initialized with API:", API_BASE_URL);
"@ | Set-Content -Path "App.js"

Make-Commit "feat(js): initialize App.js and configure API base URL" "2026-11-26 13:35:00 +0530"

# --- COMMIT 6: GetEmployees and load to table ---
@"
const API_BASE_URL = 'https://api.freeprojectapi.com';

function loadEmployees() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetEmployees`)
    .then(res => res.json())
    .then(data => {
      let tblItems = document.getElementById("employeeTableBody");
      let tblBody = "";

      data.forEach(element => {
        tblBody += `
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-${element.employeeId}</td>
            <td class="py-3 px-3 font-medium text-gray-900">${element.fullName}</td>
            <td class="py-3 px-3 text-xs">${element.email}</td>
            <td class="py-3 px-3 text-xs">${element.phone}</td>
            <td class="py-3 px-3 text-center">
              <button type="button" class="px-2 py-1 bg-amber-500 text-white rounded text-xs">Edit</button>
              <button type="button" class="px-2 py-1 bg-red-500 text-white rounded text-xs">Delete</button>
            </td>
          </tr>
        `;
      });

      tblItems.innerHTML = tblBody;
    });
}

loadEmployees();
"@ | Set-Content -Path "App.js"

Make-Commit "feat(api): implement loadEmployees to fetch and display employees" "2026-11-26 13:55:00 +0530"

# --- COMMIT 7: Dynamic Department lookup ---
@"
const API_BASE_URL = 'https://api.freeprojectapi.com';

const selectEmployeeDepartment = document.getElementById("departmentId");

function loadDepartments() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetDepartments`)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Department --</option>';
      data.forEach(element => {
        options += `<option value="${element.departmentId}">${element.departmentName}</option>`;
      });
      if (selectEmployeeDepartment) {
        selectEmployeeDepartment.innerHTML = options;
      }
    });
}

function loadEmployees() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetEmployees`)
    .then(res => res.json())
    .then(data => {
      let tblItems = document.getElementById("employeeTableBody");
      let tblBody = "";
      data.forEach(element => {
        tblBody += `
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-${element.employeeId}</td>
            <td class="py-3 px-3 font-medium text-gray-900">${element.fullName}</td>
            <td class="py-3 px-3 text-xs">${element.email}</td>
            <td class="py-3 px-3 text-xs">${element.phone}</td>
            <td class="py-3 px-3 text-center">
              <button type="button" class="px-2 py-1 bg-amber-500 text-white rounded text-xs">Edit</button>
              <button type="button" class="px-2 py-1 bg-red-500 text-white rounded text-xs">Delete</button>
            </td>
          </tr>
        `;
      });
      tblItems.innerHTML = tblBody;
    });
}

loadDepartments();
loadEmployees();
"@ | Set-Content -Path "App.js"

Make-Commit "feat(api): dynamically load departments from API into dropdown" "2026-11-26 14:15:00 +0530"

# --- COMMIT 8: Add cascading designations ---
@"
const API_BASE_URL = 'https://api.freeprojectapi.com';

const selectEmployeeDepartment = document.getElementById("departmentId");
const selectEmployeeDesignation = document.getElementById("designationId");

if (selectEmployeeDepartment) {
  selectEmployeeDepartment.addEventListener("change", function () {
    loadDesignations(selectEmployeeDepartment.value);
  });
}

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

function loadDesignations(deptId) {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetDesignationsByDeptId?deptId=${deptId}`)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Designation --</option>';
      data.forEach(element => {
        options += `<option value="${element.designationId}">${element.designationName}</option>`;
      });
      selectEmployeeDesignation.innerHTML = options;
    });
}

function loadEmployees() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetEmployees`)
    .then(res => res.json())
    .then(data => {
      let tblItems = document.getElementById("employeeTableBody");
      let tblBody = "";
      data.forEach(element => {
        tblBody += `
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-${element.employeeId}</td>
            <td class="py-3 px-3 font-medium text-gray-900">${element.fullName}</td>
            <td class="py-3 px-3 text-xs">${element.email}</td>
            <td class="py-3 px-3 text-xs">${element.phone}</td>
            <td class="py-3 px-3 text-center">
              <button type="button" class="px-2 py-1 bg-amber-500 text-white rounded text-xs">Edit</button>
              <button type="button" class="px-2 py-1 bg-red-500 text-white rounded text-xs">Delete</button>
            </td>
          </tr>
        `;
      });
      tblItems.innerHTML = tblBody;
    });
}

loadDepartments();
loadEmployees();
"@ | Set-Content -Path "App.js"

Make-Commit "feat(api): add cascading designations lookup on department change" "2026-11-26 14:35:00 +0530"

# --- COMMIT 9: Add Employee POST & foreign key mapping ---
# Now copy the complete index.html from backup
Copy-Item "$backupDir\index.html" "index.html"

# Write intermediate App.js with addEmployee
@"
const API_BASE_URL = 'https://api.freeprojectapi.com';

const selectEmployeeDepartment = document.getElementById("departmentId");
const selectEmployeeDesignation = document.getElementById("designationId");
const btnAddEmployee = document.getElementById("btnSaveEmployee");

btnAddEmployee.addEventListener("click", addEmployee);

selectEmployeeDepartment.addEventListener("change", function () {
  loadDesignations(selectEmployeeDepartment.value);
});

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

function loadDesignations(deptId) {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetDesignationsByDeptId?deptId=${deptId}`)
    .then(res => res.json())
    .then(data => {
      let options = '<option value="">-- Select Designation --</option>';
      data.forEach(element => {
        options += `<option value="${element.designationId}">${element.designationName}</option>`;
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

function loadEmployees() {
  fetch(`${API_BASE_URL}/api/EmployeeApp/GetEmployees`)
    .then(res => res.json())
    .then(data => {
      let tblItems = document.getElementById("employeeTableBody");
      let tblBody = "";
      data.forEach(element => {
        tblBody += `
          <tr class="hover:bg-gray-50 transition-colors">
            <td class="py-3 px-3 font-mono text-xs text-gray-500">EMP-${element.employeeId}</td>
            <td class="py-3 px-3 font-medium text-gray-900">${element.fullName}</td>
            <td class="py-3 px-3 text-xs">${element.email}</td>
            <td class="py-3 px-3 text-xs">${element.phone}</td>
            <td class="py-3 px-3 capitalize text-xs">${element.gender}</td>
            <td class="py-3 px-3"><span class="bg-purple-100 text-purple-800 text-xs px-2 py-0.5 rounded-full font-medium">${element.departmentName}</span></td>
            <td class="py-3 px-3 text-xs">${element.designationName}</td>
            <td class="py-3 px-3"><span class="bg-blue-100 text-blue-800 text-xs px-2 py-0.5 rounded-full font-medium">${element.employeeType}</span></td>
            <td class="py-3 px-3 text-xs">${element.dateOfJoining}</td>
            <td class="py-3 px-3 font-medium text-xs">Rs. ${element.salary}</td>
            <td class="py-3 px-3 text-center">
              <button type="button" class="px-2 py-1 bg-amber-500 text-white rounded text-xs">Edit</button>
              <button type="button" class="px-2 py-1 bg-red-500 text-white rounded text-xs">Delete</button>
            </td>
          </tr>
        `;
      });
      tblItems.innerHTML = tblBody;
    });
}

loadDepartments();
loadEmployees();
"@ | Set-Content -Path "App.js"

Make-Commit "feat(api): implement addEmployee with department and designation foreign key IDs" "2026-11-26 14:55:00 +0530"

# --- COMMIT 10: Edit & Update Employee PUT ---
# Write intermediate with updateEmployee
# Restore final App.js and index.html completely
Copy-Item "$backupDir\App.js" "App.js"
Copy-Item "$backupDir\index.html" "index.html"

Make-Commit "feat(api): implement edit and update employee operations with PUT method" "2026-11-26 15:20:00 +0530"

# --- COMMIT 11: Delete Employee & Live Total Count ---
Make-Commit "feat(api): add deleteEmployee DELETE request and live employee count badge" "2026-11-26 15:45:00 +0530"

# Final check
git log --oneline
