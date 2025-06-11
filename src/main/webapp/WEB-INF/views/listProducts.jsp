<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Catalog Dashboard</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f7f9fc;
      overflow: hidden;
    }
    .container { display: flex; height: 100vh; }
    .sidebar {
      width: 250px;
      background-color: #2c3e50;
      padding: 20px;
      color: #fff;
      box-sizing: border-box;
      flex-shrink: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .sidebar img.logo {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 20px;
    }
    .sidebar h2 { font-size: 20px; margin-bottom: 20px; text-align: center; }
    .sidebar a {
      display: block;
      color: #fff;
      text-decoration: none;
      margin: 10px 0;
      font-size: 16px;
    }
    .main {
      flex-grow: 1;
      overflow-y: auto;
      padding: 30px;
      box-sizing: border-box;
      background-color: #f7f9fc;
    }
    h1, h2, h3 { text-align: center; margin-bottom: 20px; }
    form.filters {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      justify-content: center;
      margin-bottom: 30px;
    }
    .filters input, .filters select {
      padding: 10px;
      border-radius: 4px;
      border: 1px solid #ccc;
      flex: 1 1 150px;
    }
    .filters button {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .filters button:hover { background-color: #0056b3; }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background: white;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    th, td {
      padding: 12px;
      border: 1px solid #ccc;
      text-align: center;
    }
    th { background-color: #f5f5f5; font-weight: bold; }
    .action-btn.delete {
      color: #dc3545;
      text-decoration: none;
      font-weight: bold;
    }
    .action-btn.edit {
      color: #007bff;
      text-decoration: none;
      font-weight: bold;
      margin-right: 10px;
    }
  </style>

  <script>
    let existingSkus = [];

    function updateSizeOptions() {
      const category = document.getElementById('category').value;
      const sizeSelect = document.getElementById('size');
      sizeSelect.innerHTML = '<option value="" disabled selected>Select Size</option>';

      let sizes = [];
      if (category === 'Footwear') {
        sizes = ['6', '7', '8', '9', '10'];
      } else if (category === 'Men' || category === 'Women' || category === 'Kids') {
        sizes = ['XS', 'S', 'M', 'L', 'XL'];
      }

      sizes.forEach(size => {
        const option = document.createElement('option');
        option.value = size;
        option.textContent = size;
        sizeSelect.appendChild(option);
      });

      // Preselect size if editing
      const selectedSize = "${productToEdit.size}";
      if (selectedSize) {
        sizeSelect.value = selectedSize;
      }
    }

    function validateForm() {
      const discount = document.querySelector('input[name="discount"]').value;
      const sku = document.querySelector('input[name="sku"]').value.trim().toLowerCase();
      const editing = document.querySelector('input[name="productId"]');

      if (discount > 100) {
        alert("Discount cannot be more than 100%");
        return false;
      }

      if (!editing && existingSkus.includes(sku)) {
        alert("SKU must be unique. This SKU already exists.");
        return false;
      }

      return true;
    }

    window.onload = function () {
      updateSizeOptions();

      <c:forEach var="product" items="${products}">
        existingSkus.push("${product.sku}".toLowerCase());
      </c:forEach>
    };
  </script>
</head>
<body>

<div class="container">
  <div class="sidebar">
    <img class="logo" src="https://www.nisum.com/hubfs/nisum-logo-400x400.png" alt="Nisum Logo" />
    <h2>Catalog Management System</h2>
    <a href="#">Dashboard</a>
    <a href="#">Add Category</a>
    <a href="promotions">Create Promo Code</a>
  </div>

  <div class="main">
    <h1>Catalog Dashboard</h1>

    <!-- Product Form -->
    <form action="${productToEdit != null ? 'updateProduct' : 'addProduct'}" method="post" class="filters" onsubmit="return validateForm()">
      <c:if test="${productToEdit != null}">
        <input type="hidden" name="productId" value="${productToEdit.productId}" />
      </c:if>
      <input type="text" name="name" placeholder="Product Name" required value="${productToEdit.name}" />
      <input type="text" name="sku" placeholder="SKU" required value="${productToEdit.sku}" />
      <select id="category" name="categoryName" onchange="updateSizeOptions()" required>
        <option value="" disabled ${productToEdit == null ? 'selected' : ''}>Select Category</option>
        <option value="Men" ${productToEdit.categoryName == 'Men' ? 'selected' : ''}>Men</option>
        <option value="Women" ${productToEdit.categoryName == 'Women' ? 'selected' : ''}>Women</option>
        <option value="Footwear" ${productToEdit.categoryName == 'Footwear' ? 'selected' : ''}>Footwear</option>
        <option value="Kids" ${productToEdit.categoryName == 'Kids' ? 'selected' : ''}>Kids</option>
      </select>
      <select id="size" name="size" required>
        <option value="" disabled>Select Size</option>
      </select>
      <input type="number" step="0.01" name="price" placeholder="Price" required value="${productToEdit.price}" />
      <input type="number" name="discount" placeholder="Discount (%)" required value="${productToEdit.discount}" />
      <button type="submit">${productToEdit != null ? 'Update Product' : 'Add Product'}</button>
    </form>

    <!-- Product List -->
    <table>
      <thead>
        <tr>
          <th>Category</th>
          <th>Product</th>
          <th>SKU</th>
          <th>Size</th>
          <th>Price (₹)</th>
          <th>Discount (%)</th>
          <th>Discount Price (₹)</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="product" items="${products}">
          <tr>
            <td>${product.categoryName}</td>
            <td>${product.name}</td>
            <td>${product.sku}</td>
            <td>${product.size}</td>
            <td>₹${product.price}</td>
            <td>${product.discount}</td>
            <td>₹${product.discountPrice}</td>
            <td>
              <a href="editProduct?id=${product.productId}" class="action-btn edit">✏️ Edit</a>
              <a href="deleteProduct?id=${product.productId}"
                 class="action-btn delete"
                 onclick="return confirm('Are you sure you want to delete this product?');">🗑️ Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
