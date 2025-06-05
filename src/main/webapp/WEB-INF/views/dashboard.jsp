<!DOC TYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Catalog_test Dashboard</title>
  <link rel="stylesheet" href="style.css" />
    <script src="${pageContext.request.contextPath}/js/main.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/main2.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/main3.js" defer></script>
</head>
<style>
* {
  box-sizing: border-box;
}
body {
  margin: 0;
  font-family: 'Segue UI', sans-serif;
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
.sidebar a:hover {
  color: #1abc9c;
}
.main {
  margin-left: 280px;
  padding: 30px;
}
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
.filters button:hover {
  background: #16a085;
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
  background: #f8f8f8;
}
.promo-table {
  margin-top: 40px;
}
.action-btn {
  margin: 0 5px;
  padding: 6px 12px;
  cursor: pointer;
  border: none;
  border-radius: 6px;
}
.edit {
  background: #f39c12;
  color: white;
}
.edit:hover {
  background: #e67e22;
}
.delete {
  background: #e74c3c;
  color: white;
}
.delete:hover {
  background: #c0392b;
}
</style>
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

    <!-- Moved: Add Item Section (Filters + Add Item Button) -->
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
      <input type="number" id="price" placeholder="Price" step="0.01" min="0" />
      <input type="number" id="discountPercent" placeholder="Discount (%)" step="0.01" min="0" max="100" />
      <input type="number" id="discountAmount" placeholder="Discount Amount ($)" step="0.01" min="0" readonly />
      <button onclick="addItem()">Add Item</button>
<table>
  <thead>
    <tr>
      <th>Category</th>
      <th>Product</th>
      <th>SKU</th>
      <th>Size</th>
      <th>Price ($)</th>
      <th>Discount (%)</th>
      <th>Discount Amount ($)</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody id="catalogBody"></tbody>
</table>

    </section>

    <!-- Moved: Create Promotion Section -->
    <section class="promo-section" style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Create Promotion</h2>
      <input type="text" id="promoType" placeholder="Promotion Type (e.g. Discount, Cashback)" />
      <input type="text" id="promoDesc" placeholder="Description" />
      <input type="text" id="promoCode" placeholder="Promo Code" />
      <input type="number" id="promoAmount" placeholder="Amount" min="0" step="0.01" />
      <button onclick="addPromoCode()">Add Promo Code</button>

      <table class="promo-table" style="margin-bottom: 40px;">
            <thead>
              <tr>
                <th>Promo Type</th>
                <th>Description</th>
                <th>Promo Code</th>
                <th>Amount</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody id="promoBody"></tbody>
          </table>
    </section>

    <!-- Keep these sections below -->

    <!-- Section: Category Management -->
    <section style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Category Management</h2>

      <!-- Add Category -->
      <div style="margin-bottom: 20px;">
        <input type="text" id="newCategoryName" placeholder="Category Name" style="width: 250px; padding: 6px;" />
        <button onclick="addCategory()">Add Category</button>
      </div>

      <!-- Active Categories List -->
      <div>
        <button onclick="getActiveCategories()">Refresh Active Categories</button>
        <ul id="activeCategoryList" style="margin-top: 10px; max-height: 150px; overflow-y: auto; padding-left: 20px; border: 1px solid #ddd;"></ul>
      </div>
    </section>

    <!-- Section: Product and Category Assignment -->
    <section style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Product & Category Assignment</h2>

      <div style="display: flex; gap: 20px; flex-wrap: wrap;">

        <!-- Add Product to Category -->
        <div style="flex: 1; min-width: 280px;">
          <h3>Add Product to Category</h3>
          <input type="text" id="productName" placeholder="Product Name" style="width: 100%; padding: 6px; margin-bottom: 8px;" />
          <input type="text" id="productSKU" placeholder="SKU" style="width: 100%; padding: 6px; margin-bottom: 8px;" />
          <select id="productCategorySelect" style="width: 100%; padding: 6px; margin-bottom: 8px;">
            <option value="">Select Category</option>
            <option value="Kids">Kids</option>
            <option value="Men">Men</option>
            <option value="Women">Women</option>
            <option value="Footwear">Footwear</option>
          </select>
          <button onclick="addProductToCategory()">Add Product</button>
        </div>

        <!-- Remove Product from Category -->
        <div style="flex: 1; min-width: 280px;">
          <h3>Remove Product from Category</h3>
          <input type="text" id="removeProductSKU" placeholder="Product SKU" style="width: 100%; padding: 6px; margin-bottom: 8px;" />
          <select id="removeCategorySelect" style="width: 100%; padding: 6px; margin-bottom: 8px;">
            <option value="">Select Category</option>
            <option value="Kids">Kids</option>
            <option value="Men">Men</option>
            <option value="Women">Women</option>
            <option value="Footwear">Footwear</option>
          </select>
          <button onclick="removeProductFromCategory()">Remove Product</button>
        </div>

      </div>
    </section>

    <!-- Section: Product Query -->
    <section style="margin-bottom: 40px; border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
      <h2>Product Query</h2>

      <div style="display: flex; gap: 20px; flex-wrap: wrap;">

        <!-- Get Products for Category -->
        <div style="flex: 1; min-width: 280px;">
          <h3>Get Products by Category</h3>
          <select id="categoryForProducts" style="width: 100%; padding: 6px; margin-bottom: 8px;">
            <option value="">Select Category</option>
            <option value="Kids">Kids</option>
            <option value="Men">Men</option>
            <option value="Women">Women</option>
            <option value="Footwear">Footwear</option>
          </select>
          <button onclick="getProductsForCategory()">Get Products</button>
          <ul id="productsList" style="margin-top: 10px; max-height: 150px; overflow-y: auto; padding-left: 20px; border: 1px solid #ddd;"></ul>
        </div>

        <!-- Fetch Product Info -->
        <div style="flex: 1; min-width: 280px;">
          <h3>Fetch Product Information</h3>
          <input type="text" id="fetchProductSKU" placeholder="Product SKU" style="width: 100%; padding: 6px; margin-bottom: 8px;" />
          <button onclick="fetchProductInfo()">Fetch Info</button>
          <div id="productInfoDisplay" style="margin-top: 10px; border: 1px solid #ddd; padding: 10px; min-height: 80px;"></div>
        </div>

      </div>
    </section>
  </div>




</body>
</html>