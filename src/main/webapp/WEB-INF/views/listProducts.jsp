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

    .container {
      display: flex;
      height: 100vh;
    }

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

    .sidebar h2 {
      font-size: 20px;
      margin-bottom: 20px;
      text-align: center;
    }

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

    h1, h2, h3 {
      text-align: center;
      margin-bottom: 20px;
    }

    form.filters, form.promo-form {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      justify-content: center;
      margin-bottom: 30px;
    }

    .filters input, .filters select,
    .promo-form input, .promo-form select, .promo-form textarea {
      padding: 10px;
      border-radius: 4px;
      border: 1px solid #ccc;
      flex: 1 1 150px;
    }

    .filters button, .promo-form button {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .filters button:hover, .promo-form button:hover {
      background-color: #0056b3;
    }

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

    th {
      background-color: #f5f5f5;
      font-weight: bold;
    }

    .action-btn.delete {
      color: #dc3545;
      text-decoration: none;
      font-weight: bold;
    }
  </style>

  <script>
    function updateSizeOptions() {
      const category = document.getElementById('category').value;
      const sizeSelect = document.getElementById('size');
      sizeSelect.innerHTML = '';

      let sizes = [];
      if (category === 'Footwear') {
        sizes = ['6', '7', '8', '9', '10'];
      } else {
        sizes = ['XS', 'S', 'M', 'L', 'XL'];
      }

      sizes.forEach(size => {
        const option = document.createElement('option');
        option.value = size;
        option.textContent = size;
        sizeSelect.appendChild(option);
      });
    }

    window.onload = updateSizeOptions;
  </script>
</head>
<body>

<div class="container">
  <div class="sidebar">
    <img class="logo" src="https://www.nisum.com/hubfs/nisum-logo-400x400.png" alt="Nisum Logo" />
    <h2>Catalog Management System</h2>
    <a href="#">Dashboard</a>
    <a href="#">Add Category</a>
    <a href="#">Create Promo Code</a>
  </div>

  <div class="main">
    <h1>Catalog Dashboard</h1>

    <!-- Product Form -->
    <form action="addProduct" method="post" class="filters">
      <select id="category" name="categoryName" onchange="updateSizeOptions()" required>
        <option value="Men">Men</option>
        <option value="Women">Women</option>
        <option value="Footwear">Footwear</option>
        <option value="Kids">Kids</option>
      </select>
      <select id="size" name="size" required></select>
      <input type="text" name="name" placeholder="Product Name" required />
      <input type="text" name="sku" placeholder="SKU" required />
      <input type="number" step="0.01" name="price" placeholder="Price" required />
      <input type="number" name="discount" placeholder="Discount (%)" required />
      <button type="submit">Add Product</button>
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
              <a href="deleteProduct?id=${product.productId}" class="action-btn delete">🗑️ Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- Promotion Section -->
    <h2>Create Promotion</h2>
    <form action="addPromotion" method="post" class="promo-form">
      <select name="promoType" required>
        <option value="">--Select Promotion Type--</option>
        <option value="Discount">Discount</option>
        <option value="Cashback">Cashback</option>
      </select>
      <input type="text" name="description" placeholder="Description" required />
      <input type="text" name="promoCode" placeholder="Promo Code" required />
      <input type="number" step="0.01" name="amount" placeholder="Amount" required />
      <button type="submit">Add Promo Code</button>
    </form>

    <h3>Promotion List</h3>
    <table>
      <thead>
        <tr>
          <th>Promo Type</th>
          <th>Description</th>
          <th>Promo Code</th>
          <th>Amount</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="promotion" items="${promotions}">
          <tr>
            <td>${promotion.promoType}</td>
            <td>${promotion.description}</td>
            <td>${promotion.promoCode}</td>
            <td>₹${promotion.amount}</td>
            <td>
              <a href="deletePromotion?id=${promotion.id}" class="action-btn delete">🗑️ Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>


  </div>
</div>

</body>
</html>
