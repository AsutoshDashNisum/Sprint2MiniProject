function addPromoCode() {
  const promoType = document.getElementById("promoType").value.trim();
  const promoDesc = document.getElementById("promoDesc").value.trim();
  const promoCode = document.getElementById("promoCode").value.trim();
  const promoAmount = document.getElementById("promoAmount").value.trim();

  // Placeholder for promoTypeId (you can improve logic later to match real IDs from DB)
  const promoTypeId = 1; // Change this based on how you're managing promotion types

  // Simple validation
  if (!promoType || !promoDesc || !promoCode || !promoAmount) {
    alert("Please fill in all promotion fields.");
    return;
  }

  const formData = new URLSearchParams();
  formData.append("promoType", promoType);
  formData.append("description", promoDesc);
  formData.append("promoCode", promoCode);
  formData.append("promoAmount", promoAmount);
  formData.append("promoTypeId", promoTypeId);

  fetch("addPromotion", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: formData.toString()
  })
    .then(response => response.text())
    .then(data => {
      alert(data);
      if (data.includes("successfully")) {
        appendPromoToTable(promoType, promoDesc, promoCode, promoAmount);
        clearPromoInputs();
      }
    })
    .catch(error => {
      console.error("Error:", error);
      alert("An error occurred while adding the promotion.");
    });
}

function appendPromoToTable(type, desc, code, amount) {
  const tableBody = document.getElementById("promoBody");

  const row = document.createElement("tr");

  row.innerHTML = `
    <td>${type}</td>
    <td>${desc}</td>
    <td>${code}</td>
    <td>${amount}</td>
    <td><button onclick="deletePromoCode(this)">Delete</button></td>
  `;

  tableBody.appendChild(row);
}

function clearPromoInputs() {
  document.getElementById("promoType").value = "";
  document.getElementById("promoDesc").value = "";
  document.getElementById("promoCode").value = "";
  document.getElementById("promoAmount").value = "";
}

// Optional: Implement deletion logic later if needed
function deletePromoCode(button) {
  const row = button.closest("tr");
  row.remove();
}