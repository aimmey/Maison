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

        <link rel="icon" href="image/maison-logo.png">

        <!-- Custom styles for this template -->
        <link href="carousel.css" rel="stylesheet">

        <!--font awesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

        <title>Home</title>

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
        <main role="main">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="image/slide_1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="image/slide_2.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="image/slide_3_1.jpg" alt="Third slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="image/slide_4.jpg" alt="Forth slide">
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>


            <div class="container marketing">
                <!-- START THE FEATURETTES -->
                <hr class="featurette-divider">
                <h1 style="text-align: center; color: #739072">All I want for Christmas is these furniture!</h1>
                <hr class="featurette-divider">

                <div class="row featurette">
                    <div class="col-md-7">
                        <h2 class="featurette-heading">FEJKA <span class="text-muted">Minimal Christmas Tree</span></h2>
                        <p class="lead">ต้นคริสต์มาสมินิมอลที่เหมาะสำหรับ คนที่ไม่ชอบกวาดใบไม้ร่วง เมื่อใช้เสร็จก็พับเก็บได้สะดวก</p>
                    </div>
                    <div class="col-md-5">
                        <img class="rounded-circle" src="image/mini-ChristmasTree.jpg" alt="Generic placeholder image">
                    </div>
                </div>

                <hr class="featurette-divider">

                <div class="row featurette">
                    <div class="col-md-7">
                        <h2 class="featurette-heading">MILSBO <span class="text-muted">Mistletoe</span></h2>
                        <p class="lead">ช่อ Mistletoe ช่วยให้บรรยากาศช่วงเทศกาลสดใสขึ้นได้อย่างไม่น่าเชื่อ</p>
                    </div>
                    <div class="col-md-5">
                        <img class="rounded-circle" src="image/mistletoe.jpg" alt="Generic placeholder image">
                    </div>
                </div>

                <hr class="featurette-divider">

                <div class="row featurette">
                    <div class="col-md-7">
                        <h2 class="featurette-heading">VINTER <span class="text-muted">Pine Cone</span></h2>
                        <p class="lead">ไม่ว่าเด็กหรือผู้ใหญ่ก็ล้วนเฝ้าคอยวันคริสต์มาส ของตกแต่งชิ้นนี้จะเนรมิตต้นคริสต์มาสในฝันของคุณให้เป็นจริง</p>
                    </div>
                    <div class="col-md-5">
                        <img class="rounded-circle" src="image/pine.jpg" alt="Generic placeholder image">
                    </div>
                </div>

                <hr class="featurette-divider">

                <!-- /END THE FEATURETTES -->
            </div><!-- /.container -->

            <!-- FOOTER -->
            <footer class="container">
                <p class="float-right"><a href="#">Back to top</a></p>
            </footer>
        </main>

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

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
        <script src="js/vendor/holder.min.js"></script>
        <script src="view-source:https://getbootstrap.com/docs/4.1/examples/carousel/"></script>

    </body>

</html>