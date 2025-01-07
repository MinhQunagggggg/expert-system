/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.Admin;

import DAO.userDAO;
import Entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Khuong Hung
 */
public class CustomerManager extends HttpServlet {

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
    
    try {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra nếu user có trong session
        if (user == null) {
            response.sendRedirect("user?action=login");
            return;
        }

        // Kiểm tra quyền admin
        if ("true".equalsIgnoreCase(user.getIsAdmin())) {
            String action = request.getParameter("action");

            if (action == null || action.isEmpty()) {
                userDAO dao = new userDAO();
                List<User> userList = dao.getUser();

                // Kiểm tra nếu danh sách user không rỗng
                if (userList != null && !userList.isEmpty()) {
                    request.setAttribute("user", userList);
                    request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
                } else {
                    // Nếu không có user nào, có thể chuyển hướng hoặc hiển thị thông báo khác
                    request.setAttribute("error", "No users found.");
                    request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
                }
            } else if ("update".equalsIgnoreCase(action)) {
                String userIdParam = request.getParameter("user_id");
                String isAdmin = request.getParameter("permission");

                if (userIdParam != null && !userIdParam.isEmpty() && isAdmin != null) {
                    try {
                        int userId = Integer.parseInt(userIdParam);
                        userDAO dao = new userDAO();
                        dao.setAdmin(userId, isAdmin);
                        response.sendRedirect("customermanager");
                    } catch (NumberFormatException e) {
                        // Xử lý lỗi khi user_id không phải là số hợp lệ
                        request.setAttribute("error", "Invalid user ID.");
                        request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
                    }
                } else {
                    // Xử lý lỗi nếu thiếu thông tin user_id hoặc permission
                    request.setAttribute("error", "Missing user ID or permission.");
                    request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
                }
            } else {
                // Nếu action không hợp lệ
                request.setAttribute("error", "Invalid action.");
                request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("user?action=login");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Chuyển hướng đến trang lỗi tùy chỉnh
        response.sendRedirect("404.jsp");
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
