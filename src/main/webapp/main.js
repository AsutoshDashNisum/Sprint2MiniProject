// Update size options based on category
function updateSizeOptions() {
  const category = document.getElementById("category").value;
  const sizeSelect = document.getElementById("size");
  sizeSelect.innerHTML = "<option value=''>Select Size</option>";

  let sizes = [];
  if (category === "Men" || category === "Women" || category === "Kids") {
    sizes = ["S", "M", "L", "XL"];
  } else if (category === "Footwear") {
    sizes = ["5", "6", "7", "8", "9", "10", "11", "!2"];
  }

  sizes.forEach((size) => {
    const option = document.createElement("option");
    option.value = size;
    option.textContent = size;
    sizeSelect.appendChild(option);
  });
}

// Automatically calculate Discount Amount
document.getElementById("discountPercent").addEventListener("input", function () {
  const price = parseFloat(document.getElementById("price").value) || 0;
  const discount = parseFloat(this.value) || 0;
  const discountAmt = (price * discount) / 100;
  document.getElementById("discountAmount").value = discountAmt.toFixed(2);
});

// Add product item to catalog


// Remove row from catalog or promo table
function removeRow(btn) {
  const row = btn.parentNode.parentNode;
  row.remove();
}

// Edit catalog row
function editRow(btn) {
  const row = btn.parentNode.parentNode;
  const cells = row.querySelectorAll("td");

  if (btn.textContent === "Edit") {
    for (let i = 0; i < cells.length - 1; i++) {
      const val = cells[i].textContent;
      cells[i].innerHTML = `<input type="text" value="${val}" style="width: 100px;" />`;
    }
    btn.textContent = "Save";
  } else {
    const inputs = row.querySelectorAll("input");
    const values = Array.from(inputs).map((input) => input.value);

    const price = parseFloat(values[4]);
    const discount = parseFloat(values[5]);
    const discountAmt = (price * discount) / 100;

    cells[0].textContent = values[0];
    cells[1].textContent = values[1];
    cells[2].textContent = values[2];
    cells[3].textContent = values[3];
    cells[4].textContent = price.toFixed(2);
    cells[5].textContent = discount.toFixed(2);
    cells[6].textContent = discountAmt.toFixed(2);

    btn.textContent = "Edit";
  }
}

// Add promo code to table
function addPromoCode() {
  const promoType = document.getElementById("promoType").value.trim();
  const promoDesc = document.getElementById("promoDesc").value.trim();
  const promoCode = document.getElementById("promoCode").value.trim();
  const promoAmount = parseFloat(document.getElementById("promoAmount").value);

  if (!promoType || !promoDesc || !promoCode || isNaN(promoAmount)) {
    alert("Please fill all promo fields correctly.");
    return;
  }

  const tbody = document.getElementById("promoBody");
  const row = document.createElement("tr");

  row.innerHTML = `
    <td>${promoType}</td>
    <td>${promoDesc}</td>
    <td>${promoCode}</td>
    <td>${promoAmount.toFixed(2)}</td>
    <td>
      <button onclick="editPromoRow(this)">Edit</button>
      <button onclick="removeRow(this)">Delete</button>
    </td>
  `;

  tbody.appendChild(row);

  document.getElementById("promoType").value = "";
  document.getElementById("promoDesc").value = "";
  document.getElementById("promoCode").value = "";
  document.getElementById("promoAmount").value = "";
}

// Edit promo row
function editPromoRow(btn) {
  const row = btn.parentNode.parentNode;
  const cells = row.querySelectorAll("td");

  if (btn.textContent === "Edit") {
    for (let i = 0; i < cells.length - 1; i++) {
      const val = cells[i].textContent;
      cells[i].innerHTML = `<input type="text" value="${val}" style="width: 120px;" />`;
    }
    btn.textContent = "Save";
  } else {
    const inputs = row.querySelectorAll("input");
    const values = Array.from(inputs).map((input) => input.value);

    const amount = parseFloat(values[3]);

    cells[0].textContent = values[0];
    cells[1].textContent = values[1];
    cells[2].textContent = values[2];
    cells[3].textContent = amount.toFixed(2);
    btn.textContent = "Edit";
  }
}

// Your existing code remains unchanged above this point...

// --- ADDITIONS START ---

// Categories to populate dynamically
const categories = ["Men", "Women", "Kids", "Footwear"];
const promoTypes = ["Seasonal", "Clearance", "Festive", "Member Exclusive"];

// Populate category dropdown on page load
function populateCategoryOptions() {
  const categorySelect = document.getElementById("category");
  categorySelect.innerHTML = "<option value=''>Select Category</option>";
  categories.forEach(cat => {
    const option = document.createElement("option");
    option.value = cat;
    option.textContent = cat;
    categorySelect.appendChild(option);
  });
  // Trigger size update in case default category is selected
  updateSizeOptions();
}

// Populate promo type dropdown on page load
function populatePromoTypeOptions() {
  const promoTypeSelect = document.getElementById("promoType");
  promoTypeSelect.innerHTML = "<option value=''>Select Promo Type</option>";
  promoTypes.forEach(type => {
    const option = document.createElement("option");
    option.value = type;
    option.textContent = type;
    promoTypeSelect.appendChild(option);
  });
}

// SKU uniqueness check before adding product
function isSkuUnique(sku) {
  const rows = document.querySelectorAll("#catalogBody tr");
  for (let row of rows) {
    if (row.children[2].textContent === sku) {
      return false;
    }
  }
  return true;
}

// Modify addItem to check SKU uniqueness
function addItem() {
  const product = document.getElementById("product").value.trim();
  const sku = document.getElementById("sku").value.trim();
  const category = document.getElementById("category").value;
  const size = document.getElementById("size").value;
  const price = parseFloat(document.getElementById("price").value);
  const discount = parseFloat(document.getElementById("discountPercent").value);
  const discountAmount = parseFloat(document.getElementById("discountAmount").value);

  if (!product || !sku || !category || !size || isNaN(price) || isNaN(discount) || isNaN(discountAmount)) {
    alert("Please fill all fields correctly.");
    return;
  }

  if (!isSkuUnique(sku)) {
    alert("SKU must be unique. This SKU already exists.");
    return;
  }

  const tbody = document.getElementById("catalogBody");
  const row = document.createElement("tr");

  row.innerHTML = `
    <td>${category}</td>
    <td>${product}</td>
    <td>${sku}</td>
    <td>${size}</td>
    <td>${price.toFixed(2)}</td>
    <td>${discount.toFixed(2)}</td>
    <td>${discountAmount.toFixed(2)}</td>
    <td>
      <button onclick="editRow(this)">Edit</button>
      <button onclick="removeRow(this)">Delete</button>
    </td>
  `;

  tbody.appendChild(row);

  // Clear input fields
  document.getElementById("product").value = "";
  document.getElementById("sku").value = "";
  document.getElementById("category").value = "";
  document.getElementById("size").innerHTML = "<option value=''>Select Size</option>";
  document.getElementById("price").value = "";
  document.getElementById("discountPercent").value = "";
  document.getElementById("discountAmount").value = "";
}

// Call this on page load to initialize dropdowns
window.addEventListener("DOMContentLoaded", () => {
  populateCategoryOptions();
  populatePromoTypeOptions();
});