<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_staff.aspx.cs" Inherits="lap_trinh_wed.admin.admin_staff" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Quản lý nhân sự</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fff; }
        .wrapper { display: flex; }

        /* Sidebar chuẩn theo ảnh */
        .sidebar {
            width: 320px; border-right: 1px solid #ddd;
            height: 100vh; position: fixed; padding: 40px 20px;
        }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area img { width: 60px; margin-bottom: 10px; }
        .logo-area h2 { font-size: 28px; font-weight: bold; }
        
        .nav-menu { list-style: none; }
        .nav-item { 
            display: block; padding: 15px 30px; text-decoration: none; color: #333;
            font-size: 20px; font-weight: 600; border-radius: 30px; margin-bottom: 10px;
        }
        .nav-item.active { background-color: #fff0f3; border: 1px solid #eee; }

        /* Main Content */
        .main-content { margin-left: 320px; padding: 60px 50px; width: 100%; }
        .header-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .header-row h1 { font-size: 45px; font-weight: bold; }

        /* Search Bar & Add Button */
        .action-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .search-wrapper { position: relative; width: 60%; }
        .search-wrapper i { position: absolute; left: 20px; top: 15px; color: #888; font-size: 20px; }
        .txt-search { 
            width: 100%; padding: 12px 20px 12px 55px; border-radius: 25px; 
            border: 1px solid #888; font-size: 18px; outline: none;
        }
        .btn-add {
            background-color: #e2f49d; border: 1px solid #888; padding: 12px 30px;
            border-radius: 25px; font-size: 18px; font-weight: bold; cursor: pointer;
            display: flex; align-items: center; gap: 10px;
        }

        /* Table Design */
        .table-container { border: 1px solid #000; border-radius: 25px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { 
            border-bottom: 1px solid #000; padding: 20px; text-align: left; 
            font-size: 18px; font-weight: bold; background: #fff;
        }
        td { padding: 20px; font-size: 16px; color: #333; border-bottom: 1px solid #eee; }
        .btn-detail { color: #ff8fa3; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-area">
                    <img src="../assets/anh/logo.png" alt="Lily Spa" />
                    <h2>Lily Spa</h2>
                    <p>Quản trị viên</p>
                </div>
                <div class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item">Tổng quan</a>
                    <a href="admin_appointment.aspx" class="nav-item">Quản lý lịch hẹn</a>
                    <a href="admin_customer.aspx" class="nav-item">Quản lý khách hàng</a>
                    <a href="admin_staff.aspx" class="nav-item active">Quản lý nhân sự</a>
                    <a href="admin_service.aspx" class="nav-item">Quản lý dịch vụ</a>
                </div>
            </aside>

            <main class="main-content">
                <div class="header-row">
                    <h1>Quản lý Nhân sự</h1>
                </div>

                <div class="action-bar">
                    <div class="search-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="txt-search" placeholder="Tìm kiếm nhân sự theo tên hoặc SĐT"></asp:TextBox>
                    </div>
                    <button type="button" class="btn-add">+ Thêm nhân sự</button>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Họ và tên</th>
                                <th>SĐT</th>
                                <th>Chức vụ</th>
                                <th>Ca làm việc</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptStaff" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("ho_ten") %></td>
                                        <td><%# Eval("sdt") %></td>
                                        <td><%# Eval("chuc_vu") %></td>
                                        <td><%# Eval("ca_lam") %></td>
                                        <td><%# Eval("trang_thai") %></td>
                                        <td><a href='admin_staff_detail.aspx?id=<%# Eval("id") %>' class="btn-detail">Chi tiết</a></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td>Nguyễn Thị Lan</td>
                                <td>0987 123 456</td>
                                <td>Kỹ thuật viên</td>
                                <td>Ca sáng (8h - 17h), Nghỉ thứ 2</td>
                                <td>Đang làm việc</td>
                                <td><a href="#" class="btn-detail">Chi tiết</a></td>
                            </tr>
                            <tr>
                                <td>Trần Minh Quân</td>
                                <td>0912 345 678</td>
                                <td>Bác sĩ</td>
                                <td>Ca chiều (13h - 21h), Làm thứ 3 - CN</td>
                                <td>Đang làm việc</td>
                                <td><a href="#" class="btn-detail">Chi tiết</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </form>
</body>
</html>