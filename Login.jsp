<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/product/product.css">

        <!--font awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <link rel="icon" href="image/maison-logo.png">

        <title>Login</title>

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
        
        

        <div>
            <form action="Login" method="post" style="  width: 100%; max-width: 330px;padding: 15px;margin: auto;">
                <img style="margin-bottom: 1.5rem!important;vertical-align: middle;border-style: none;" src="image/maison-logo.png" alt="" width="300" height="300">
                <div class="form-group">
                    <label for="exampleInputEmail1">Username</label>
                    <input type="text" name="username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Username" required>
<!--                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>-->
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-outline-info">Login</button>
                <br><br>
                <a href="Register">Register</a>
            </form>
        </div>


        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>
        <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/holder.min.js"></script>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </body>

</html>