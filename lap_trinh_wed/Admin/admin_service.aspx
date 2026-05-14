<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_service.aspx.cs" Inherits="lap_trinh_wed.admin.admin_service" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Quản lý dịch vụ</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fcfcfc; }
        .wrapper { display: flex; }

        /* Sidebar rộng và hiện đại theo mẫu khách hàng */
        .sidebar {
            width: 350px; background: #fff; border-right: 1px solid #eee;
            display: flex; flex-direction: column; padding: 50px 30px;
            position: fixed; height: 100vh;
        }
        .logo-box { display: flex; align-items: center; gap: 20px; padding-bottom: 30px; border-bottom: 1px solid #f5f5f5; margin-bottom: 40px; }
        .logo-circle { width: 75px; height: 75px; border-radius: 50%; border: 1px solid #ddd; display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .logo-circle img { width: 85%; height: auto; }
        .logo-text h2 { font-size: 30px; font-weight: bold; }
        
        .nav-menu { display: flex; flex-direction: column; gap: 15px; flex-grow: 1; }
        .nav-item { text-decoration: none; color: #333; padding: 18px 25px; border-radius: 35px; font-size: 19px; font-weight: bold; display: flex; align-items: center; gap: 15px; transition: 0.3s; }
        .nav-item.active { background-color: #fff0f3; color: #f04581; }
        .nav-item:hover:not(.active) { background-color: #f9f9f9; }

        /* Main Content */
        .main-content { margin-left: 350px; padding: 80px 60px; width: 100%; }
        .header-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .main-content h1 { font-size: 50px; font-weight: bold; color: #000; }

        /* Action Bar: Search & Add */
        .action-bar { display: flex; justify-content: space-between; align-items: center; gap: 20px; margin-bottom: 35px; }
        .search-wrapper { position: relative; flex: 1; }
        .search-wrapper i { position: absolute; left: 25px; top: 18px; color: #888; font-size: 20px; }
        .txt-search { 
            width: 100%; padding: 15px 25px 15px 60px; border-radius: 35px; 
            border: 2px solid #ddd; font-size: 18px; outline: none; transition: 0.3s;
        }
        .txt-search:focus { border-color: #f04581; box-shadow: 0 0 10px rgba(240, 69, 129, 0.1); }
        
        .btn-add {
            background-color: #e2f49d; border: 2px solid #ddd; padding: 15px 35px;
            border-radius: 35px; font-size: 18px; font-weight: bold; cursor: pointer;
            display: inline-flex; align-items: center; gap: 10px; text-decoration: none; color: #000;
            transition: 0.3s;
        }
        .btn-add:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }

        /* Table kiểu khung đen bo góc như mockup */
        .table-container {
            background: #fff; border-radius: 30px; overflow: hidden; 
            border: 1px solid #000;
        }
        table { width: 100%; border-collapse: collapse; }
        th { 
            background: #fff; padding: 25px 20px; text-align: left; 
            font-size: 18px; font-weight: bold; border-bottom: 1px solid #000;
        }
        td { padding: 20px; font-size: 16px; color: #333; border-bottom: 1px solid #eee; vertical-align: middle; }
        
        .img-placeholder { 
            width: 50px; height: 60px; border: 1px solid #ffcad4; 
            border-radius: 10px; background: #fff; display: block;
        }

        /* Nút hành động */
        .btn-edit { color: #52c41a; font-weight: bold; text-decoration: none; font-size: 16px; margin-right: 15px; }
        .btn-delete { color: #f5222d; font-weight: bold; text-decoration: none; font-size: 16px; border: none; background: none; cursor: pointer; }
        .btn-edit:hover, .btn-delete:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-box">
                    <div class="logo-circle">
                        <img src="../assets/anh/logo.png" alt="Logo" />
                    </div>
                    <div class="logo-text">
                        <h2>Lily Spa</h2>
                        <span style="color: #888; font-size: 14px;">Quản trị viên</span>
                    </div>
                </div>
                <nav class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
                    <a href="admin_appointment.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Lịch hẹn</a>
                    <a href="admin_customer.aspx" class="nav-item"><i class="fa-solid fa-users"></i> Khách hàng</a>
                    <a href="admin_staff.aspx" class="nav-item"><i class="fa-solid fa-user-tie"></i> Nhân sự</a>
                    <a href="admin_service.aspx" class="nav-item active"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
                </nav>
            </aside>

            <main class="main-content">
                <h1>Quản Lý dịch vụ</h1>

                <div class="action-bar">
                    <div class="search-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="txt-search" placeholder="Tìm kiếm danh mục theo chữ cái đầu..."></asp:TextBox>
                    </div>
                    <a href="admin_service_add.aspx" class="btn-add">+ Thêm dịch vụ</a>
                </div>

                <div class="table-container">
                    <asp:Repeater ID="rptServices" runat="server">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên dịch vụ</th>
                                        <th>Loại</th>
                                        <th>Thời gian</th>
                                        <th>Giá tiền</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><div class="img-placeholder"></div></td>
                                <td><strong><%# Eval("TenDichVu") %></strong></td>
                                <td><%# Eval("Loai") %></td>
                                <td><%# Eval("ThoiGian") %></td>
                                <td style="font-weight: bold;"><%# Eval("GiaTien") %></td>
                                <td>
                                    <a href='admin_service_edit.aspx?id=<%# Eval("ID") %>' class="btn-edit">Sửa</a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete" Text="Xóa" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </main>
        </div>
    </form>
</body>
</html>