const API_BASE_URL = 'https://api.freeprojectapi.com';

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

loadEmployees();
