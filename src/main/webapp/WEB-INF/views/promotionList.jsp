<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Promotion Management</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #ecf0f3;
    }

    .container {
      display: flex;
      height: 100vh;
      overflow: hidden;
    }

    .sidebar {
      width: 280px;
      background: linear-gradient(180deg, #2c3e50, #34495e);
      color: #fff;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 30px 15px;
    }

    .sidebar img.logo {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 20px;
      border: 3px solid #1abc9c;
      background: white;
    }

    .sidebar h2 {
      text-align: center;
      font-size: 20px;
      margin-bottom: 25px;
    }

    .sidebar a {
      text-decoration: none;
      color: #fff;
      padding: 10px 20px;
      width: 100%;
      display: block;
      border-radius: 6px;
      margin: 8px 0;
      transition: background 0.3s ease;
    }

    .sidebar a:hover {
      background-color: #1abc9c;
    }

    .sidebar a.active {
      background-color: #1abc9c;
      font-weight: bold;
    }

    .main {
      flex-grow: 1;
      padding: 30px;
      overflow-y: auto;
      background: #f4f7fa;
    }

    h1 {
      text-align: center;
      color: #2c3e50;
    }

    form.promo-form {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
      justify-content: center;
      margin: 25px 0;
    }

    .promo-form input,
    .promo-form select {
      padding: 10px 14px;
      border-radius: 5px;
      border: 1px solid #ccc;
      width: 180px;
    }

    .promo-form button {
      padding: 10px 20px;
      border: none;
      background: #1abc9c;
      color: white;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    .promo-form button:hover {
      background: #16a085;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #eaeff5;
      font-weight: 600;
      color: #2c3e50;
    }

    td {
      color: #333;
    }

    .btn {
      text-decoration: none;
      padding: 6px 12px;
      border-radius: 4px;
      color: white;
      font-size: 14px;
    }

    .edit-btn {
      background-color: #f0ad4e;
    }

    .edit-btn:hover {
      background-color: #ec971f;
    }

    .delete-btn {
      background-color: #d9534f;
    }

    .delete-btn:hover {
      background-color: #c9302c;
    }

    @media screen and (max-width: 768px) {
      .container {
        flex-direction: column;
      }

      .sidebar {
        flex-direction: row;
        justify-content: space-around;
        padding: 15px;
        width: 100%;
        height: auto;
      }

      .main {
        padding: 15px;
      }

      .promo-form {
        flex-direction: column;
        align-items: center;
      }

      .promo-form input,
      .promo-form select,
      .promo-form button {
        width: 100%;
        max-width: 300px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="sidebar">
    <img class="logo" src="https://www.nisum.com/hubfs/nisum-logo-400x400.png" alt="Nisum Logo" />
    <h2>Catalog Management</h2>
    <a href="${pageContext.request.contextPath}/products">Dashboard</a>
    <a href="${pageContext.request.contextPath}/addCategory">Add Category</a>
    <a href="${pageContext.request.contextPath}/promotions" class="active">Create Promo Code</a>
  </div>

  <div class="main">
    <h1>Available Promotions</h1>

    <form action="${pageContext.request.contextPath}/${promotion.id == 0 ? 'addPromotion' : 'updatePromotion'}" method="post" class="promo-form">
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
              <a href="${pageContext.request.contextPath}/editPromotion?id=${promo.id}" class="btn edit-btn">Edit</a>
              <a href="${pageContext.request.contextPath}/deletePromotion?id=${promo.id}" class="btn delete-btn" onclick="return confirm('Are you sure you want to delete this promotion?')">Delete</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
