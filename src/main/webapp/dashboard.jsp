<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOC TYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Catalog_test Dashboard</title>
  <style>
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #ecf0f3;
    }
    .sidebar {
      width: 280px;
      background: linear-gradient(180deg, #2c3e50, #34495e);
      color: #fff;
      height: 100vh;
      position: fixed;
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .sidebar img {
      width: 100px;
      border-radius: 50%;
      margin-bottom: 20px;
    }
    .sidebar h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 20px;
    }
    .sidebar a {
      display: block;
      color: #fff;
      text-decoration: none;
      margin: 15px 0;
      transition: all 0.3s;
    }
    .sidebar a:hover { color: #1abc9c; }
    .main { margin-left: 280px; padding: 30px; }
    h1 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }
    .filters input, .filters select {
      margin: 5px;
      padding: 10px;
      width: 180px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }
    .filters button {
      padding: 10px 20px;
      background: #1abc9c;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: 0.3s;
    }
    .filters button:hover { background: #16a085; }
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
    th { background: #f8f8f8; }
    .promo-table { margin-top: 40px; }
  </style>

</head>

<body>
  <div class="sidebar">
    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQKTBK1Fq3i4bFVgeVTT2kyXHTj_tMKQbE8Q&s" alt="Logo" />
    <h2>Catalog Management</h2>
    <a href="#">Dashboard</a>
    <a href="#">Add Category</a>
    <a href="#">Create Promo Code</a>
  </div>

  <div class="main">
    <h1>Catalog Dashboard</h1>

    <section class="filters" style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Add Item</h2>
      <input type="text" id="product" placeholder="Product Name" />
      <input type="text" id="sku" placeholder="SKU" />
      <select id="category" onchange="updateSizeOptions()">
        <option value="">Select Category</option>
        <option value="Kids">Kids</option>
        <option value="Men">Men</option>
        <option value="Women">Women</option>
        <option value="Footwear">Footwear</option>
      </select>
      <select id="size">
        <option value="">Select Size</option>
      </select>
      <input type="number" id="price" placeholder="Price" step="0.01" min="0" oninput="calculateDiscount()" />
      <input type="number" id="discountPercent" placeholder="Discount (%)" step="0.01" min="0" max="100" oninput="calculateDiscount()" />
      <input type="number" id="discountAmount" placeholder="Discount Amount" step="0.01" min="0" readonly />
      <button type="button" onclick="addItem()">Add Item</button>

      <table>
        <thead>
          <tr>
            <th>Category</th>
            <th>Product</th>
            <th>SKU</th>
            <th>Size</th>
            <th>Price</th>
            <th>Discount (%)</th>
            <th>Discount Amount</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody id="catalogBody"></tbody>
      </table>
    </section>

    <section class="promo-section" style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Create Promotion</h2>
      <input type="text" id="promoType" placeholder="Promotion Type (e.g. Discount, Cashback)" />
      <input type="text" id="promoDesc" placeholder="Description" />
      <input type="text" id="promoCode" placeholder="Promo Code" />
      <input type="number" id="promoAmount" placeholder="Amount" min="0" step="0.01" />
      <button type="button">Add Promo Code</button>
      <table class="promo-table">
        <thead>
          <tr>
            <th>Promo Code</th>
            <th>Promo Type</th>
            <th>Description</th>
            <th>Promo Amount</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="promo" items="${promoList}">
            <tr>
              <td>${promo.promoCode}</td>
              <td>${promo.promoType}</td>
              <td>${promo.description}</td>
              <td>${promo.promoAmount}</td>
              <td>
                <button class="edit">Edit</button>
                <button class="delete">Delete</button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </section>
  </div>

  <script src="main.js"></script>
  <script src="main2.js"></script>
  <script src="main3.js"></script>
</body>
</html>
