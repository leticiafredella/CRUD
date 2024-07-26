<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    if(request.getParameter("submit") != null) {
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");

        Connection con;
        PreparedStatement pst;
        
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/academy","root","");
        pst = con.prepareStatement("insert into records(stname,course,fee)values(?,?,?)");
        pst.setString(1, name);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.executeUpdate();
%>

<script>
    alert("Record Added");
</script>

<%
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Registration System</title>
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
        }
        .btn {
            margin-right: 5px;
        }
        .table-responsive {
            overflow-x: auto; 
        }
        .table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
            overflow: hidden;
            white-space: nowrap; /* Prevent text from wrapping */
            text-overflow: ellipsis; /* Show ellipsis if text overflows */
            border: 1px solid #ddd; /* Add border to table cells */
        }
        .table th {
            background-color: #f2f2f2; /* Optional: Add background color to header */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Student Registration System CRUD using JSP</h1>
        
        <div class="row">
            <div class="col-sm-4">
                <form method="POST" action="#">
                    <div class="form-group">
                        <label class="form-label">Student Name</label>
                        <input type="text" class="form-control" placeholder="Student Name" name="sname" id="sname" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Course</label>
                        <input type="text" class="form-control" placeholder="Course" name="course" id="course" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Fee</label>
                        <input type="text" class="form-control" placeholder="Fee" name="fee" id="fee" required>
                    </div>
                    
                    <div class="form-group">
                        <input type="submit" id="submit" value="Submit" name="submit" class="btn btn-info">
                        <input type="reset" id="reset" value="Reset" name="reset" class="btn btn-warning">
                    </div>
                </form>
            </div>
            
            <div class="col-sm-8">
                <div class="panel-body">
                    <table id="tbl-student" class="table table-responsive" cellpadding="0" width="100%">
                        <thead>
                            <tr>
                                <th>Student Name</th>
                                <th>Course</th>
                                <th>Fee</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection con;
                                PreparedStatement pst;
                                ResultSet rs;

                                Class.forName("com.mysql.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost/academy","root","");
                                
                                String query = "select * from records";
                                Statement st = con.createStatement();
                                
                                rs = st.executeQuery(query);
                                
                                while(rs.next()) {
                                String id = rs.getString("id");
                            %>
                            
                            <tr>
                                <td><%=rs.getString("stname") %></td>
                                <td><%=rs.getString("course") %></td>
                                <td><%=rs.getString("fee") %></td>
                                <td><a href="update.jsp?id=<%=id%>" class="btn btn-warning btn-sm">Edit</a></td>
                                <td><a href="delete.jsp?id=<%=id%>" class="btn btn-danger btn-sm">Delete</a></td>
                            </tr>
                            
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>