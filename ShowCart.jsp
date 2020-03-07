<%-- 
    Document   : ShowCart
    Created on : Nov 27, 2018, 4:56:52 PM
    Author     : aimmy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/product/product.css">

        <link href="https://getbootstrap.com/docs/4.1/examples/album/album.css" rel="stylesheet">
        <link rel="icon" href="image/maison-logo.png">

        <!--font awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

        <title>ShowCart</title>

    </head>
    <body>
        <nav class="site-header sticky-top py-1">
            <div class="container d-flex flex-column flex-md-row justify-content-between">

                <a class="py-2 d-none d-md-inline-block" href="Home">Home</a>
                <a class="py-2 d-none d-md-inline-block" href="Bedroom">Bedroom</a>
                <a class="py-2 d-none d-md-inline-block" href="Bathroom">Bathroom</a>
                <a class="py-2 d-none d-md-inline-block" href="LivingRoom">Living room</a>
                <a class="py-2 d-none d-md-inline-block" href="Kitchen">Kitchen</a>
                <a class="py-2 d-none d-md-inline-block" href="Outdoor">Outdoor</a>
                <form action="Search" class="form-inline">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search">
                    <button class="btn btn-outline-light" type="submit">Search</button></a>
                </form>

                <c:if test="${sessionScope.customer == null}">
                    <a class="py-2 d-none d-md-inline-block" href="Login"><i class="fas fa-user"></i> Login</a>
                </c:if>

                <c:if test="${sessionScope.customer != null}">
                    <lable class="py-2 d-none d-md-inline-block" style="color: whitesmoke"><i class="fas fa-user"></i> ${customer.fname}</lable>
                    <a class="py-2 d-none d-md-inline-block" href="Logout">Logout</a>
                </c:if>
                <a class="py-2 d-none d-md-inline-block" href="Cart"><i class="fas fa-shopping-cart"></i> Cart <span class="badge badge-light">${cart.totalQuantity}</span></a>
            </div>
        </nav>

        ${errMsg}
        <!--main-->
        <div style="  width: 100%; max-width: 1000px;padding: 15px;margin: auto;">
            <div class="py-5 text-center">
                <img class="d-block mx-auto mb-4" src="image/maison-logo.png" alt="" width="300" height="300">
                <h1><span class="badge badge-dark">Cart</span></h1>
            </div>
            <br>

            <br><br>
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                Your cart <span class="badge badge-secondary badge-pill">${cart.totalQuantity}</span>
            </h4>
                
        <div class="container">
            <table class="table">
                <thead>
                <th>No</th>
                <th>Img</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Unit price</th>
                <th>Total price</th>
                <th></th>
                </thead>
                <c:set var="items" value="${sessionScope.cart.lineItems}"/>

                <c:forEach items="${cart.lineItems}" var="line" varStatus="vs">
                    <tr>

                        <td>${vs.count}</td>
                        <td><img src="Image2/${line.product.productid}.jpg" style="height: auto; width: 200px"></td>
                        <td>${line.product.productname}</td>
                        <td>${line.quantity}</td>
                        <td>${line.salePrice}</td>
                        <td>${line.totalPrice}</td>
                        
                        <td><a class="btn btn-outline-info" href="Increase?quantity=${line.quantity}&index=${vs.count}&productId=${line.product.productid}">+</a></td>
                        <td><a class="btn btn-outline-info" href="Reduce?quantity=${line.quantity}&index=${vs.count}&productId=${line.product.productid}">-</a></td>
                        <td><a class="btn btn-outline-info" href="Remove?productId=${line.product.productid}">remove</a></td>

                    </tr>
                </c:forEach>

                <thead>
                <th></th>
                <th></th>
                <th></th>
                <th>Total Quantity</th>
                <th> </th>
                <th>Grand Total price</th>
                </thead>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${cart.totalQuantity}</td>
                    <td></td>
                    <td>${cart.totalPrice}</td>
                </tr>
            </table>
            <br>
            <a href="GoToCheckOut">check out</a>
        </div>
    </body>
</html>
