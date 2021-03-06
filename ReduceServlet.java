/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controller.ProductJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.LineItem;
import model.Product;
import model.ShoppingCart;

/**
 *
 * @author Goddamnz
 */
public class ReduceServlet extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        String productId = request.getParameter("productId");

        ProductJpaController pCtrl = new ProductJpaController(utx, emf);
        Product product = pCtrl.findProduct(productId);

        String quantity = request.getParameter("quantity");
        int quantityNum = Integer.parseInt(quantity);
        String index = request.getParameter("index");
        System.out.println(index);
        int indexNum = Integer.parseInt(index);
        quantityNum--;
        indexNum--;

        if (quantityNum <= 0) {
            cart.remove(product);
            session.setAttribute("cart", cart);
            response.sendRedirect("Cart");
            return;
        }

        List item = cart.getLineItems();
        LineItem temp = new LineItem();
        temp = (LineItem) item.get(indexNum);
        temp.setQuantity(quantityNum);
        item.set(indexNum, temp);

        session.setAttribute("cart", cart);
        response.sendRedirect("Cart");

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
