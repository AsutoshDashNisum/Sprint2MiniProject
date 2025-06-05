<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Promotion Management</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f7f9fc;
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

    h1 {
      text-align: center;
      margin-bottom: 20px;
    }

    form.promo-form {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      justify-content: center;
      margin-bottom: 30px;
    }

    .promo-form input,
    .promo-form select {
      padding: 10px;
      border-radius: 4px;
      border: 1px solid #ccc;
      flex: 1 1 150px;
    }

    .promo-form button {
      padding: 10px 20px;
      background-color: #28a745;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .promo-form button:hover {
      background-color: #218838;
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

    .btn {
      padding: 6px 10px;
      text-decoration: none;
      border-radius: 4px;
      color: white;
      margin: 0 2px;
      display: inline-block;
    }

    .edit-btn {
      background-color: #ffc107;
    }

    .delete-btn {
      background-color: #dc3545;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="sidebar">
    <img class="logo" src="https://www.nisum.com/hubfs/nisum-logo-400x400.png" alt="Nisum Logo" />
    <h2>Catalog Management System</h2>
    <a href="products">Dashboard</a>
    <a href="addCategory">Add Category</a>

  </div>

  <div class="main">
    <h1>Available Promotions</h1>

    <!-- Add / Edit Promotion Form -->
    <form action="${promotion.id == 0 ? 'addPromotion' : 'updatePromotion'}" method="post" class="promo-form">
      <input type="hidden" name="id" value="${promotion.id}" />
      <select name="promoType" required>
        <option value="">Select Type</option>
        <option value="Discount" ${promotion.promoType == 'Discount' ? 'selected' : ''}>Discount</option>
        <option value="Cashback" ${promotion.promoType == 'Cashback' ? 'selected' : ''}>Cashback</option>
      </select>
      <input type="text" name="description" placeholder="Description" value="${promotion.description}" required />
      <input type="text" name="promoCode" placeholder="Promo Code" value="${promotion.promoCode}" required />
      <input type="number" step="0.01" name="amount" placeholder="Amount" value="${promotion.amount}" required />
      <button type="submit">${promotion.id == 0 ? 'Add Promotion' : 'Update Promotion'}</button>
    </form>

    <!-- Promotion List Table -->
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Promo Type</th>
          <th>Description</th>
          <th>Promo Code</th>
          <th>Amount</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="promo" items="${promotions}">
          <tr>
            <td>${promo.id}</td>
            <td>${promo.promoType}</td>
            <td>${promo.description}</td>
            <td>${promo.promoCode}</td>
            <td>₹${promo.amount}</td>
            <td>
              <a href="editPromotion?id=${promo.id}" class="btn edit-btn">Edit</a>
              <a href="deletePromotion?id=${promo.id}" class="btn delete-btn" onclick="return confirm('Are you sure you want to delete this promotion?')">Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
