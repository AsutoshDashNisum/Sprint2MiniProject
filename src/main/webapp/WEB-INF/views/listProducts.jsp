<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Product List</h2>
<a href="dashboard">Add New Product</a>

<table border="1" cellpadding="8" cellspacing="0">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>SKU</th>
    <th>Category</th>
    <th>Size</th>
    <th>Price</th>
    <th>Discount (%)</th>
    <th>Discount Price</th>
    <th>Action</th>
  </tr>

  <c:forEach var="product" items="${products}">
    <tr>
      <td>${product.productId}</td>
      <td>${product.name}</td>
      <td>${product.sku}</td>
      <td>${product.categoryName}</td>
      <td>${product.size}</td>
      <td>${product.price}</td>
      <td>${product.discount}</td>
      <td>${product.discountPrice}</td>
      <td>
        <a href="deleteProduct?id=${product.productId}">Delete</a>
      </td>
    </tr>
  </c:forEach>
</table>
