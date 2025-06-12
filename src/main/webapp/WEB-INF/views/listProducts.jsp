<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getRequestURI();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Catalog Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    html, body { margin:0; padding:0; height:100%; font-family:'Segoe UI',sans-serif; background:#f4f6f8; }
    .container { display:flex; min-height:100vh; }
    .sidebar {
      width:250px; background:linear-gradient(180deg,#2c3e50,#34495e);
      color:white; padding:20px; display:flex; flex-direction:column; align-items:center;
    }
    .sidebar img.logo { width:100px; height:100px; margin-bottom:20px; border-radius:50%; border:2px solid white; }
    .sidebar h2 { font-size:18px; margin-bottom:30px; text-align:center; }
    .sidebar a {
      color:white; text-decoration:none; padding:10px; margin:5px 0;
      width:100%; text-align:center; border-radius:5px;
      background-color:transparent; transition:background-color .3s;
    }
    .sidebar a:hover, .sidebar a.active { background-color:#1abc9c; font-weight:bold; }
    .main { flex:1; padding:30px; background:#ecf0f3; overflow-x:auto; }
    h1 { text-align:center; color:#333; }
    .table-actions { text-align:right; margin-bottom:10px; }
    .table-actions button {
      margin-left:10px; padding:8px 14px; font-size:14px; border:none; border-radius:4px; cursor:pointer;
    }
    .add-btn { background-color:#27ae60; color:white; }
    .edit-btn, .delete-btn { background-color:#e74c3c; color:white; }
    .delete-btn { background-color:#c0392b; }
    button:disabled { background-color:#bdc3c7; cursor:not-allowed; }
    table {
      width:100%; border-collapse:collapse; background:white;
      box-shadow:0 0 10px rgba(0,0,0,0.1);
    }
    th,td { padding:12px; text-align:center; border:1px solid #ddd; }
    th { background:#f5f5f5; font-weight:bold; }
    tbody tr:hover { background:#f0f8ff; }

    /* Modal */
    .modal { display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%; overflow:auto; background-color:rgba(0,0,0,0.4); }
    .modal-content {
      background:#fff; margin:8% auto; padding:20px; border:1px solid #888;
      width:90%; max-width:600px; border-radius:8px; position:relative;
    }
    .close { position:absolute; top:10px; right:15px; font-size:24px; font-weight:bold; cursor:pointer; }
    form.modal-form {
      display:flex; flex-wrap:wrap; gap:10px; justify-content:center;
    }
    form.modal-form input, form.modal-form select {
      padding:10px; border:1px solid #ccc; border-radius:5px; flex:1 1 200px;
    }
    form.modal-form button { background:#3498db; color:white; padding:10px 20px; border:none; border-radius:5px; cursor:pointer; }
    @media (max-width:768px) {
      .container { flex-direction:column; }
      .sidebar { flex-direction:row; flex-wrap:wrap; justify-content:space-around; width:100%; }
      .sidebar a { margin:5px; padding:8px; font-size:14px; }
    }
  </style>

  <script>
    let existingSkus = [];

    function populateModal(mode, data = {}) {
      document.getElementById('modalTitle').textContent = mode === 'edit' ? 'Edit Product' : 'Add Product';
      const form = document.getElementById('modal-form');
      form.action = mode === 'edit' ? 'updateProduct' : 'addProduct';
      ['productId','name','sku','categoryName','size','price','discount'].forEach(field => {
        const el = form.querySelector('[name="' + field + '"]');
        if (data[field] !== undefined && el) el.value = data[field];
      });
      // populate size dropdown and select
      updateSizeOptions();
      if (mode === 'edit') document.getElementById('modal-size').value = data.size;
      openModal();
    }

    function updateSizeOptions() {
      const cat = document.getElementById('modal-category').value;
      const sizeEl = document.getElementById('modal-size');
      sizeEl.innerHTML = '<option value="" disabled>Select Size</option>';
      let sizes = [];
      if (cat === 'Footwear') sizes = ['6','7','8','9','10'];
      else if (['Men','Women','Kids'].includes(cat)) sizes = ['XS','S','M','L','XL'];
      sizes.forEach(s => {
        const o = document.createElement('option');
        o.value = s; o.textContent = s;
        sizeEl.appendChild(o);
      });
    }

    function validateModalForm() {
      const form = document.getElementById('modal-form');
      const disc = parseFloat(form.discount.value);
      const sku = parseInt(form.sku.value.trim());
      const editing = !!form.productId.value;
      if (disc > 100) { alert("Discount > 100%"); return false; }
      if (!editing && existingSkus.includes(sku)) { alert("SKU exists"); return false; }
      return true;
    }

    function openModal() { document.getElementById('productModal').style.display = 'block'; }
    function closeModal() { document.getElementById('productModal').style.display = 'none'; }

    function onCheckboxClick() {
      const sel = document.querySelectorAll('input[name="selProd"]:checked');
      document.getElementById('editBtn').disabled = sel.length !== 1;
      document.getElementById('deleteBtn').disabled = sel.length === 0;
    }

    function handleEdit() {
      const sel = document.querySelector('input[name="selProd"]:checked');
      if (!sel) return;
      const row = sel.closest('tr');
      const data = {
        productId: sel.value,
        categoryName: row.cells[1].textContent,
        name: row.cells[2].textContent,
        sku: row.cells[3].textContent,
        size: row.cells[4].textContent,
        price: row.cells[5].textContent.replace('₹',''),
        discount: row.cells[6].textContent
      };
      populateModal('edit', data);
    }

    function handleDelete() {
      const sel = document.querySelectorAll('input[name="selProd"]:checked');
      if (sel.length && confirm("Delete selected?")) {
        const f = document.getElementById('deleteForm');
        document.getElementById('deleteIds').innerHTML = '';
        sel.forEach(i => {
          const h = document.createElement('input');
          h.type='hidden'; h.name='ids'; h.value=i.value;
          document.getElementById('deleteIds').appendChild(h);
        });
        f.submit();
      }
    }

    window.onload = function() {
      <c:forEach var="p" items="${products}">
        existingSkus.push(parseInt("${p.sku}"));
      </c:forEach>
    };
  </script>
</head>
<body>
<div class="container">
  <div class="sidebar">
    <img src="https://www.nisum.com/hubfs/nisum-logo-400x400.png" alt="Logo" class="logo"/>
    <h2>Catalog Management</h2>
    <a href="products" class="active">Dashboard</a>
    <a href="addCategory" class="<%= path.contains("/addCategory")?"active":"" %>">Add Category</a>
    <a href="promotions" class="<%= path.contains("/promotions")?"active":"" %>">Create Promo Code</a>
  </div>
  <div class="main">
    <h1>Catalog Dashboard</h1>

    <div class="table-actions">
      <button class="add-btn" onclick="populateModal('add')">+ Add Product</button>
      <button class="edit-btn" id="editBtn" onclick="handleEdit()" disabled>Edit</button>
      <button class="delete-btn" id="deleteBtn" onclick="handleDelete()" disabled>Delete</button>
    </div>

    <form id="deleteForm" action="deleteProduct" method="post"><div id="deleteIds"></div></form>

    <table>
      <thead>
        <tr>
          <th>Select</th><th>Category</th><th>Product</th><th>SKU</th>
          <th>Size</th><th>Price (₹)</th><th>Discount (%)</th><th>Discount Price (₹)</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="product" items="${products}">
          <tr>
            <td><input type="checkbox" name="selProd" value="${product.productId}" onclick="onCheckboxClick()"/></td>
            <td>${product.categoryName}</td>
            <td>${product.name}</td>
            <td>${product.sku}</td>
            <td>${product.size}</td>
            <td>₹${product.price}</td>
            <td>${product.discount}</td>
            <td>₹${product.discountPrice}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<!-- Modal -->
<div id="productModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2 id="modalTitle" style="text-align:center;">Add Product</h2>
    <form id="modal-form" class="modal-form" method="post" onsubmit="return validateModalForm()">
      <input type="hidden" name="productId" />
      <input type="text" name="name" placeholder="Product Name" required />
      <input type="number" name="sku" id="modal-sku" placeholder="SKU" required />
      <select name="categoryName" id="modal-category" onchange="updateSizeOptions()" required>
        <option value="" disabled>Select Category</option>
        <option>Men</option><option>Women</option><option>Footwear</option><option>Kids</option>
      </select>
      <select name="size" id="modal-size" required><option value="" disabled>Select Size</option></select>
      <input type="number" name="price" step="0.01" placeholder="Price" required />
      <input type="number" name="discount" id="modal-discount" placeholder="Discount (%)" required />
      <button type="submit">Save Product</button>
    </form>
  </div>
</div>
</body>
</html>
