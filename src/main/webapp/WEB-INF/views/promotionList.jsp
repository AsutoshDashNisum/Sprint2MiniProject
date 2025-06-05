<!-- promotions.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Promotions</title></head>
<body>
    <h2>Available Promotions</h2>
    <table border="1">
        <tr>
            <th>Promo Code</th>
            <th>Type</th>
            <th>Description</th>
            <th>Amount</th>
        </tr>
        <c:forEach var="promo" items="${promotions}">
           <tr>
               <td>${promo.id}</td>             <%-- PromoTypeId --%>
               <td>${promo.promoType}</td>      <%-- PromoType (String) --%>
               <td>${promo.description}</td>    <%-- Description --%>
               <td>${promo.promoCode}</td>      <%-- PromoCode --%>
               <td>${promo.amount}</td>         <%-- PromoAmount --%>
           </tr>

        </c:forEach>
    </table>
</body>
</html>
