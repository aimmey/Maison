/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controller.CustomerJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import javax.annotation.Resource;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;
import model.Customer;

/**
 *
 * @author Lali
 */
public class RegisterServlet extends HttpServlet {

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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String postcode = request.getParameter("postcode");
        String email = request.getParameter("email");
        String creditNo = request.getParameter("creditNo");

        if (username != null && password != null && username.trim().length() > 0 && password.trim().length() > 0) {
            CustomerJpaController cCtrl = new CustomerJpaController(utx, emf);
            Customer customer = cCtrl.findCustomerByUsername(username);
            if (customer == null) {
                Customer newCust = new Customer();

                newCust.setCustomerid(genCustomerId());
                newCust.setUsername(username);
                newCust.setPassword(cryptWithMD5(password));
                newCust.setFname(fname);
                newCust.setLname(lname);
                newCust.setGender(gender);
                newCust.setPhone(phone);
                newCust.setAddress(address);
                newCust.setPostcode(postcode);
                newCust.setEmail(email);
                newCust.setCreditno(creditNo);
                try {
                    cCtrl.create(newCust);
                } catch (Exception e) {
                    System.out.println(e);
                }
                response.sendRedirect("Login");
                return;
            }
            
            
            request.setAttribute("errMsg", "<div class='alert alert-danger' role='alert'>  Already have this username</div>");
            getServletContext().getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }
        getServletContext().getRequestDispatcher("/Register.jsp").forward(request, response);
    }

    public static String cryptWithMD5(String pass) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] passBytes = pass.getBytes();
            md.reset();
            byte[] digested = md.digest(passBytes);
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < digested.length; i++) {
                sb.append(Integer.toHexString(0xff & digested[i]));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            System.out.println(ex);
        }
        return null;
    }

    private String genCustomerId() {
        String customer = "ID";
        Random rd = new Random();
        CustomerJpaController cCtrl = new CustomerJpaController(utx, emf);
        Customer cust = new Customer();

        while (cust != null) {
            while (customer.length() != 7) {
                int id = rd.nextInt(10);
                String stId = String.valueOf(id);
                customer = customer + stId;
            }
            cust = cCtrl.findCustomer(customer);
        }

        return customer;

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
