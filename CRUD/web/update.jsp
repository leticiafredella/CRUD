<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    if(request.getParameter("submit")!=null)
    {
        String id = request.getParameter("id");
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/academy","root","");
        pst = con.prepareStatement("update records set stname = ?, course =?, fee = ? where id = ?");
        pst.setString(1, name);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.setString(4, id);
        pst.executeUpdate();
%>

<script>
    alert("Record Updated");
</script>

<%
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Update</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <style>
        .container {
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-container {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            margin: 0 auto; 
            max-width: 600px; 
        }
        .btn {
            margin-right: 5px;
        }
        .align-right {
            text-align: right;
        }
        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Student Update</h1>
        
        <div class="row">
            <div class="col-sm-12">
                <div class="form-container">
                    <form method="POST" action="#">
                        <%
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;

                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost/academy","root","");
                            
                            String id = request.getParameter("id");
                            
                            pst = con.prepareStatement("select * from records where id = ?");
                            pst.setString(1, id);
                            rs = pst.executeQuery();
                            
                            while(rs.next()) {
                        %>
                        
                        <div class="form-group">
                            <label class="form-label">Student Name</label>
                            <input type="text" class="form-control" placeholder="Student Name" value="<%= rs.getString("stname") %>" name="sname" id="sname" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Course</label>
                            <input type="text" class="form-control" placeholder="Course" value="<%= rs.getString("course") %>" name="course" id="course" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Fee</label>
                            <input type="text" class="form-control" placeholder="Fee" value="<%= rs.getString("fee") %>" name="fee" id="fee" required>
                        </div>
                        
                        <%
                            }
                        %>
                        
                        <div class="form-group align-right">
                            <input type="submit" id="submit" value="Submit" name="submit" class="btn btn-info">
                            <input type="reset" id="reset" value="Reset" name="reset" class="btn btn-warning">
                            <a href="index.jsp" class="btn btn-secondary">Back</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>