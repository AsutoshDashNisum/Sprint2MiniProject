function addProductItem() {
  console.log("Function Called");
}

function addItem() {
  console.log("function called");
  const formData = new URLSearchParams();
  const product = document.getElementById('product').value.trim();
  const sku = document.getElementById('sku').value.trim();
  const category = document.getElementById('category').value;
  const size = document.getElementById('size').value;
  const price = parseFloat(document.getElementById('price').value);
  const discountPercent = parseFloat(document.getElementById('discountPercent').value);
  const discountAmount = document.getElementById('discountAmount').value;

  if (!product || !sku || !category || !size || isNaN(price) || isNaN(discountPercent)) {
    alert('Please fill all fields correctly!');
    return;
  }

  formData.append('name', product);
  formData.append('sku', sku);
  formData.append('categoryName', category);
  formData.append('size', size);
  formData.append('price', price);
  formData.append('discount', discountPercent);
  formData.append('discountPrice', discountAmount);

  console.log('Sending:', formData.toString());

  fetch('/MiniProject2/addProduct', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: formData.toString(),
  })
  .then(response => response.text())
  .then(data => {
    console.log('Server response:', data);
    alert(data);

    if (data.toLowerCase().includes('success')) {
      const tbody = document.getElementById('catalogBody');
      const tr = document.createElement('tr');

      tr.innerHTML = `
        <td>${category}</td>
        <td>${product}</td>
        <td>${sku}</td>
        <td>${size}</td>
        <td>${price.toFixed(2)}</td>
        <td>${discountPercent.toFixed(2)}</td>
        <td>${parseFloat(discountAmount).toFixed(2)}</td>
        <td>
          <button onclick="editRow(this)">Edit</button>
          <button onclick="removeRow(this)">Delete</button>
        </td>
      `;

      tbody.appendChild(tr);

      // Clear input fields
      document.getElementById('product').value = '';
      document.getElementById('sku').value = '';
      document.getElementById('category').value = '';
      document.getElementById('size').innerHTML = '<option value="">Select Size</option>';
      document.getElementById('price').value = '';
      document.getElementById('discountPercent').value = '';
      document.getElementById('discountAmount').value = '';
    }
  })
  .catch(error => {
    console.error('Error:', error);
    alert('Error adding product.');
  });
}

function removeRow(button) {
  const row = button.closest('tr');
  if (row) row.remove();
}

function editRow(button) {
  const row = button.closest('tr');
  const cells = row.querySelectorAll('td');
  const isEditing = button.textContent === 'Save';

  if (!isEditing) {
    // Switch to edit mode
    for (let i = 0; i < cells.length - 1; i++) {
      const text = cells[i].textContent;
      cells[i].innerHTML = `<input type="text" value="${text}" style="width: 100px;" />`;
    }
    button.textContent = 'Save';
  } else {
    // Save edited values
    for (let i = 0; i < cells.length - 1; i++) {
      const input = cells[i].querySelector('input');
      if (input) {
        cells[i].textContent = input.value;
      }
    }
    button.textContent = 'Edit';
  }
}