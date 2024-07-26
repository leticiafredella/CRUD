<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/academy", "root", "");

        pst = con.prepareStatement("DELETE FROM records WHERE id = ?");
        pst.setString(1, id);
        int affectedRows = pst.executeUpdate();

        if (affectedRows > 0) {
%>
            <script>
                alert("Record Deleted");
                window.location.href = 'index.jsp';
            </script>
<%
        } else {
%>
            <script>
                alert("Record not found or already deleted.");
                window.location.href = 'index.jsp';
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Error occurred: <%= e.getMessage() %>");
            window.location.href = 'index.jsp';
        </script>
<%
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>