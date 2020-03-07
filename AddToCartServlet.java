/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controller.ProductJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Product;
import model.ShoppingCart;

/**
 *
 * @author aimmy
 */
public class AddToCartServlet extends HttpServlet {

    @PersistenceUnit(unitName = "MaisonPU")
    EntityManagerFactory emf;

    @Resource
    UserTransaction utx;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        String productid = request.getParameter("productid");
        ProductJpaController pCtrl = new ProductJpaController(utx, emf);
        Product p = pCtrl.findProduct(productid);
        cart.add(p);
        String page = request.getParameter("page");
        System.out.println(page);
        if (page.equals("Bedroom") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>  Add To Cart</div>");
            getServletContext().getRequestDispatcher("/Bedroom").forward(request, response);
            return;
        } else if (page.equals("Bathroom") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>   Add To Cart</div>");
            getServletContext().getRequestDispatcher("/Bathroom").forward(request, response);
            return;
        } else if (page.equals("Livingroom") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>   Add To Cart</div>");
            getServletContext().getRequestDispatcher("/LivingRoom").forward(request, response);
            return;
        } else if (page.equals("Kitchen") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>   Add To Cart</div>");
            getServletContext().getRequestDispatcher("/Kitchen").forward(request, response);
            return;
        } else if (page.equals("Outdoor") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>   Add To Cart</div>");
            getServletContext().getRequestDispatcher("/Outdoor").forward(request, response);
            return;
        } else if (page.equals("Description") == true) {
            request.setAttribute("msg", "<div class='alert alert-success' role='alert'>   Add To Cart</div>");
            getServletContext().getRequestDispatcher("/Description?productid=" + productid).forward(request, response);
            return;

        }

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
