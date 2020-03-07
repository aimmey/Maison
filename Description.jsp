<%-- 
    Document   : Description
    Created on : Aug 31, 2018, 11:04:26 AM
    Author     : INT303
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

        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/4.1/examples/blog/blog.css" rel="stylesheet">

        <title>Description</title>

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
                <form class="form-inline">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">Search</button>
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


        <div style="width: 100%; max-width: 1300px;padding: 15px;margin: auto;">
            <h1><span class="badge badge-dark">Description</span></h1><br>
            <div class="card flex-md-row mb-4 shadow-sm h-md-auto">
                <div class="card-body d-flex flex-column align-items-start">
                    <h3 class="mb-0">${product.productname}</h3>
                    <p class="card-text mb-auto"><b>Product ID:</b> ${product.productid}</p>
                    <p class="card-text mb-auto"><b>Product Name:</b> ${product.productname}</p>
                    <p class="card-text mb-auto"><b>Product Detail:</b> ${product.productdetail}</p>
                    <p class="card-text mb-auto"><b>Width:</b> ${product.productWidth}</p>
                    <p class="card-text mb-auto"><b>Length:</b> ${product.productLength}</p>
                    <p class="card-text mb-auto"><b>Height:</b> ${product.productHeight}</p>
                    <p class="card-text mb-auto"><b>Price:</b> ${product.price}</p>
                </div>
                <img class="card-img-right flex-auto d-none d-lg-block" src="Image2/${product.productid}.jpg" alt="Card image cap">
            </div>
            <br>
            <a href="AddToCart?productid=${product.productid}&page=Description">
                <button type="button" class="btn btn-sm btn-outline-secondary">Add to cart</button>
            </a>    
        </div>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/holder.min.js"></script>
        <script>
            Holder.addTheme('thumb', {
                bg: '#55595c',
                fg: '#eceeef',
                text: 'Thumbnail'
            });
        </script>
    </body>
</html>