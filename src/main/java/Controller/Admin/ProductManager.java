/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.Admin;

import DAO.productDAO;
import Entity.Category;
import Entity.Color;
import Entity.Product;
import Entity.Size;
import Entity.User;
//import com.nimbusds.oauth2.sdk.Response;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Khuong Hung
 */
public class ProductManager extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null || !user.getIsAdmin().equalsIgnoreCase("true")) {
                response.sendRedirect("user?action=login");
                return; // Exit the method if user is not admin
            }

            productDAO dao = new productDAO();

            if (action == null || action.isEmpty()) {
                List<Product> products = dao.getProduct();
                List<Size> sizes = dao.getSize();
                List<Color> colors = dao.getColor();
                List<Category> categories = dao.getCategory();
                request.setAttribute("CategoryData", categories);
                request.setAttribute("ProductData", products);
                request.setAttribute("SizeData", sizes);
                request.setAttribute("ColorData", colors);
                request.getRequestDispatcher("/admin/product.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("insert")) {
                List<Category> categories = dao.getCategory();
                request.setAttribute("CategoryData", categories);
                request.getRequestDispatcher("/admin/productinsert.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("insertcategory")) {
                String name = request.getParameter("name");
                Category existingCategory = dao.getCategoryByName(name);
                if (existingCategory != null) {
                    request.setAttribute("error", name + " already exists.");
                    request.getRequestDispatcher("admin/productinsert.jsp").forward(request, response);
                } else {
                    dao.insertCategory(name);
                    response.sendRedirect("productmanager?action=insert");
                }

            } else if (action.equalsIgnoreCase("insertproduct")) {
                try {
                    String product_id = request.getParameter("product_id");
            String category_id = request.getParameter("category_id");
            String product_name = request.getParameter("product_name");
            String product_price = request.getParameter("price");
            String product_size = request.getParameter("size");
            String product_color = request.getParameter("color");
            String product_quantity = request.getParameter("quantity");
            String product_img = "images/" + request.getParameter("product_img");
            String product_describe = request.getParameter("describe");
            
            int quantity = Integer.parseInt(product_quantity);
            Float price = Float.parseFloat(product_price);
            int cid = Integer.parseInt(category_id);
            
            Category category = new Category(cid);
            List<Size> sizeList = parseSizes(product_id, product_size);
            List<Color> colorList = parseColors(product_id, product_color);
            
            Product product = new Product();
            product.setCate(category);
            product.setProduct_id(product_id);
            product.setProduct_name(product_name);
            product.setProduct_price(price);
            product.setProduct_describe(product_describe);
            product.setQuantity(quantity);
            product.setImg(product_img);
            product.setSize(sizeList);
            product.setColor(colorList);
            
            dao.insertProduct(product);
            response.sendRedirect("productmanager?action=insert");
                }  catch (Exception e) {
                    e.printStackTrace(); // Log the error for debugging
                    response.sendRedirect("qrcode.jsp");
                }
            } else if (action.equalsIgnoreCase("deleteproduct")) {
                String product_id = request.getParameter("product_id");
                dao.ProductDelete(product_id);
                response.sendRedirect("productmanager");

            } else if (action.equalsIgnoreCase("updateproduct")) {
                String product_id = request.getParameter("product_id");
                String category_id = request.getParameter("category_id");
                String product_name = request.getParameter("product_name");
                String product_price = request.getParameter("product_price");
                String product_size = request.getParameter("product_size");
                String product_color = request.getParameter("product_color");
                String product_quantity = request.getParameter("product_quantity");
                String product_img = "images/" + request.getParameter("product_img");
                String product_describe = request.getParameter("product_describe");

                int quantity = Integer.parseInt(product_quantity);
                Float price = Float.parseFloat(product_price);
                int cid = Integer.parseInt(category_id);

                Category category = new Category(cid);
                List<Size> sizeList = parseSizes(product_id, product_size);
                List<Color> colorList = parseColors(product_id, product_color);

                Product product = new Product();
                product.setCate(category);
                product.setProduct_id(product_id);
                product.setProduct_name(product_name);
                product.setProduct_price(price);
                product.setProduct_describe(product_describe);
                product.setQuantity(quantity);
                product.setImg(product_img);
                product.setSize(sizeList);
                product.setColor(colorList);

                dao.updateProduct(product);
                response.sendRedirect("productmanager");
            }

        } catch (Exception e) {
            response.sendRedirect("404.jsp");
        }
    }

    private List<Size> parseSizes(String productId, String sizeString) {
        List<Size> sizeList = new ArrayList<>();
        String[] sizes = sizeString.split("\\s*,\\s*");
        for (String size : sizes) {
            sizeList.add(new Size(productId, size));
        }
        return sizeList;
    }

    private List<Color> parseColors(String productId, String colorString) {
        List<Color> colorList = new ArrayList<>();
        String[] colors = colorString.split("\\s*,\\s*");
        for (String color : colors) {
            colorList.add(new Color(productId, color));
        }
        return colorList;
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
