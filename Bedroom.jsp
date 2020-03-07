<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
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

        <title>Bedroom</title>

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

        <!--        <section class="jumbotron text-center">
                    <div class="container">
                        <h1 class="jumbotron-heading">Bedroom</h1>
                        <p class="lead text-muted">Let's sleep in heaven.</p>
                    </div>
                </section>-->

        <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light" style=" background-image: url('roomsimage/BedroomHead2.jpg');">
            <div class="col-md-5 p-lg-5 mx-auto my-5">
                <h1 class="display-4 font-weight-normal"></h1>
                <p class="lead font-weight-normal"></p>
            </div>
        </div>

        <main role="main">


            <div class="album py-5 bg-light">
                <div class="container">
                    <div class="row">
                        <c:forEach items="${productList}" var="p" varStatus="vs">
                            <div class="col-md-4">
                                <div class="card mb-4 shadow-sm">
                                    <img class="card-img-top" src="Image2/${p.productid}.jpg" alt="Card image cap">
                                    <div class="card-body">
                                        <p class="card-text"><b>${p.productname}</b></p>
                                        <p class="card-text">${p.productdetail}</p>
                                        <p class="card-text"><b>${p.productWidth} cm. X ${p.productLength} cm. X ${p.productHeight} cm.</b></p>
                                        <p class="card-text"><b>${p.price} THB</b></p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="btn-group">

                                                <a href="AddToCart?productid=${p.productid}&page=Bedroom">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary">Add to cart</button>
                                                </a>
                                                <a href="Description?productid=${p.productid}&page=Bedroom">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary">More detail</button>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </main>

        <!-- FOOTER -->
        <footer class="container">
            <p class="float-right"><a href="#">Back to top</a></p>
        </footer>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
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

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="view-source:https://getbootstrap.com/docs/4.1/examples/carousel/"></script>
    </body>

</html>