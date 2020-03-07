<%-- 
    Document   : Checkout
    Created on : Nov 29, 2018, 2:03:05 AM
    Author     : Goddamnz
--%>

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

        <!-- Custom styles for this template -->
        <link href="https://getbootstrap.com/docs/4.1/examples/checkout/form-validation.css" rel="stylesheet">
        <link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/product/product.css">

        <link rel="icon" href="image/maison-logo.png">

        <!--font awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

        <title>Checkout</title>

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
        ${msg}

        <!--main-->
        <div style="  width: 100%; max-width: 1000px;padding: 15px;margin: auto;">
            <div class="py-5 text-center">
                <img class="d-block mx-auto mb-4" src="image/maison-logo.png" alt="" width="300" height="300">
                <h1><span class="badge badge-dark">Checkout</span></h1>
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
                            <td><img src="Image2/${line.product.productid}.jpg" style="height: 20; width: 200px"></td>
                            <td>${line.product.productname}</td>
                            <td>${line.quantity}</td>
                            <td>${line.salePrice}</td>
                            <td>${line.totalPrice}</td>
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
                <div class="container">


                    <div style="width: 100%; max-width: 1000px;padding: 15px;margin: auto;">
                        <h1><span class="badge badge-dark">Checkout form</span></h1>
                        <br>
                        <h4 class="mb-3">Billing address</h4>
                        <form class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">First name</label>
                                    <input type="text" class="form-control" id="firstName" value="${customer.fname}" readonly required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName">Last name</label>
                                    <input type="text" class="form-control" id="lastName" value="${customer.lname}" readonly required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" value="${customer.email}" readonly required>
                            </div>

                            <div class="mb-3">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" value="${customer.address}" name="editAddress" required>
                                <div class="invalid-feedback">
                                    Address required.
                                </div>
                                <br>
                                <form action="Checkout" method="post">
                                    <button type="submit" class="btn btn-outline-info" >Edit address</button>
                                </form>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label for="zip">Zip</label>
                                    <input type="text" class="form-control" id="zip" value="${customer.postcode}" required>
                                    <div class="invalid-feedback">
                                        Zip code required.
                                    </div>
                                </div>
                            </div>
                            <hr class="mb-4">

                            <h4 class="mb-3">Payment</h4>

                            <div class="d-block my-3">
                                <div class="custom-control custom-radio">
                                    <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked required>
                                    <label class="custom-control-label" for="credit">Credit card</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="cc-number">Credit card number</label>
                                    <input type="text" class="form-control" id="cc-number" value="${customer.creditno}" readonly required>
                                    <div class="invalid-feedback">
                                        Credit card number is required
                                    </div>
                                </div>
                            </div>
                            <hr class="mb-4">
                        </form>
                    </div>
                    <form action="AfterCheckout" method="post">
                        <button type="submit" class="btn btn-outline-info">Confirm Order</button>
                    </form>
                </div>


            </div>
        </div>

        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/holder.min.js"></script>
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
                'use strict';

                window.addEventListener('load', function () {
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    var forms = document.getElementsByClassName('needs-validation');

                    // Loop over them and prevent submission
                    var validation = Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>
    </body>
</html>
