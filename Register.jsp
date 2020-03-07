<%-- 
    Document   : Register
    Created on : Nov 26, 2018, 10:08:40 PM
    Author     : aimmy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/product/product.css">

        <link rel="icon" href="image/maison-logo.png">
        
        <!--font awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

        <title>Register</title>
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

        <form action="Register" method="post" style="  width: 100%; max-width: 1000px;padding: 15px;margin: auto;">
            <h1><span class="badge badge-dark">Register</span></h1>
            <div class="form-row">
                <div class="col">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>
                <!--                <div class="col">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                                </div>-->
            </div>
            <br>
            <div class="form-row">
                <div class="col">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Password" id="txtNewPassword" required />
                </div>
                <div class="col">
                    <label for="exampleInputPassword2">Confirm Password</label>
                    <input type="password" name="password2" class="form-control" placeholder="Comfirm Password"id="txtConfirmPassword" onChange="checkPasswordMatch();" required/>
                </div>

            </div>
            <div class="form-row">
                <div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
            </div>

            <br>
            <label>Name</label>
            <div class="form-row">
                <div class="form-group col-md-4">
                    <input type="text" name="fname" class="form-control" placeholder="First name" required>
                </div>
                <div class="form-group col-md-4">
                    <input type="text" name="lname" class="form-control" placeholder="Last name" required>
                </div>
            </div>
            <label>Gender</label>
            <div class="form-check">

                <input class="form-check-input position-static" type="radio" name="gender" value="Male" checked="on" required> Male<br>
                <input class="form-check-input position-static" type="radio" name="gender" value="Female" required> Female
            </div>

            <br>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="inputEmail4">Email</label>
                    <input type="email" name="email" class="form-control" id="inputEmail4" placeholder="Email" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label>Tel.</label>
                    <input type="tel" name="phone" class="form-control" placeholder="Ex. 09845393XX" required>
                </div>
            </div>

            <div class="form-group">
                <label for="inputAddress">Address</label>
                <input type="text" name="address" class="form-control" id="inputAddress" placeholder="1234 Main St" required>
            </div>

            <div class="form-row">
                <div class="form-group col-md-2">
                    <label for="inputZip">Post Code</label>
                    <input type="text" name="postcode" class="form-control" id="inputZip" pattern="[0-9]{5}" required>
                    <small class="form-text text-muted">5 digits</small>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label>Credit Card No.</label>
                    <input type="tel" name="creditNo" class="form-control" pattern="[0-9]{16}" required>
                    <small class="form-text text-muted">16 digits</small>
                </div>
            </div>

            <br>

            <button type="submit" class="btn btn-outline-info">Register</button>
        </form>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script>
                        function checkPasswordMatch() {
                            var password = $("#txtNewPassword").val();
                            var confirmPassword = $("#txtConfirmPassword").val();

                            if (password != confirmPassword)
                                $("#divCheckPasswordMatch").html("<small style='color:red;'>Passwords do not match!</small>");
                            else
                                $("#divCheckPasswordMatch").html("<small style='color:green;'>Passwords match.</small>");
                        }

                        $(document).ready(function () {
                            $("#txtConfirmPassword").keyup(checkPasswordMatch);
                        });
        </script>
    </body>
</html>
