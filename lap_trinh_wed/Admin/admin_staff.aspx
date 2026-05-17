<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_staff.aspx.cs" Inherits="lap_trinh_wed.admin.admin_staff" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Quản lý nhân sự</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fcfcfc; }
        .wrapper { display: flex; }

        /* Sidebar - Same as dashboard */
        .sidebar { 
            width: 350px; background: #fff; border-right: 1px solid #eee; 
            display: flex; flex-direction: column; padding: 50px 30px; 
            position: fixed; height: 100vh; 
        }
        .logo-box { 
            display: flex; align-items: center; gap: 20px; padding-bottom: 30px; 
            border-bottom: 1px solid #f5f5f5; margin-bottom: 40px; 
        }
        .logo-circle { 
            width: 75px; height: 75px; border-radius: 50%; border: 1px solid #ddd; 
            display: flex; align-items: center; justify-content: center; overflow: hidden; 
        }
        .logo-circle img { width: 85%; height: auto; }
        .logo-text h2 { font-size: 30px; font-weight: bold; }
        .logo-text span { color: #888; font-size: 16px; }
        
        .nav-menu { display: flex; flex-direction: column; gap: 15px; flex-grow: 1; }
        .nav-item { 
            text-decoration: none; color: #333; padding: 18px 25px; border-radius: 35px; 
            font-size: 19px; font-weight: bold; display: flex; align-items: center; gap: 15px; 
            transition: 0.3s; 
        }
        .nav-item.active { 
            background-color: #fff0f3; color: #f04581; 
        }
        .nav-item:hover { background-color: #f9f9f9; }
        .logout-item { 
            margin-top: auto; color: #ff4d4f !important; border-top: 1px solid #eee; 
            padding-top: 25px !important; 
        }

        /* Main Content */
        .main-content { margin-left: 350px; padding: 80px 100px; width: 100%; }
        .page-header { margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center; }
        .page-title { font-size: 40px; font-weight: bold; color: #333; }
        .page-time { color: #888; display: flex; align-items: center; gap: 10px; }

        /* Action Bar */
        .action-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            margin-bottom: 40px; gap: 20px; 
        }
        .search-section { display: flex; gap: 15px; align-items: center; flex: 1; }
        .search-wrapper { 
            position: relative; flex: 1; 
        }
        .search-wrapper i { 
            position: absolute; left: 25px; top: 18px; color: #888; font-size: 20px; z-index: 2; 
        }
        .txt-search { 
            width: 100%; padding: 18px 25px 18px 65px; border-radius: 35px; 
            border: 2px solid #eee; font-size: 18px; outline: none; transition: 0.3s;
            background: #fff;
        }
        .txt-search:focus { border-color: #f04581; box-shadow: 0 0 0 3px rgba(240,69,129,0.1); }
        
        .btn-search, .btn-add {
            background: #f04581; color: white; border: none; padding: 18px 35px;
            border-radius: 35px; font-size: 18px; font-weight: bold; cursor: pointer;
            display: flex; align-items: center; gap: 12px; text-decoration: none;
            transition: 0.3s; box-shadow: 0 4px 15px rgba(240,69,129,0.3);
        }
        .btn-add { background: #52c41a; box-shadow: 0 4px 15px rgba(82,196,26,0.3); }
        .btn-search:hover, .btn-add:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.15); }

        /* Table Design */
        .table-container { 
            background: #fff; border: 2px solid #eee; border-radius: 25px; 
            overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        table { width: 100%; border-collapse: collapse; }
        th { 
            padding: 25px 30px; text-align: left; font-size: 18px; font-weight: bold; 
            background: linear-gradient(135deg, #fff 0%, #fcfcfc 100%); 
            border-bottom: 2px solid #f0f0f0; color: #333;
        }
        td { 
            padding: 25px 30px; font-size: 17px; color: #555; 
            border-bottom: 1px solid #f5f5f5; 
        }
        tr:hover td { background-color: #fff5f8; }
        
        .status-active { color: #52c41a; font-weight: bold; }
        .status-inactive { color: #ff4d4f; font-weight: bold; }
        
        .btn-detail { 
            color: #f04581; text-decoration: none; font-weight: bold; 
            padding: 12px 25px; border: 2px solid #f04581; border-radius: 25px;
            display: inline-flex; align-items: center; gap: 8px;
            transition: 0.3s;
        }
        .btn-detail:hover { 
            background-color: #f04581; color: white; 
            transform: translateY(-2px); box-shadow: 0 5px 15px rgba(240,69,129,0.4);
        }

        /* No Data */
        .no-data { 
            text-align: center; padding: 80px 40px; color: #888; font-size: 20px;
            background: #fff; border-radius: 25px;
        }
        .no-data i { font-size: 64px; margin-bottom: 30px; color: #ddd; display: block; }

        @media (max-width: 1200px) {
            .main-content { padding: 60px 40px; }
            .sidebar { width: 300px; }
            .main-content { margin-left: 300px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-box">
                    <div class="logo-circle">
                        <img src="../assets/anh/logo.png" alt="Lily Spa" 
                             onerror="this.src='../assets/anh/default-logo.png'" />
                    </div>
                    <div class="logo-text">
                        <h2>Lily Spa</h2>
                        <span runat="server" id="lblUserRole">Quản trị viên</span>
                    </div>
                </div>
                <nav class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item">
                        <i class="fa-solid fa-chart-pie"></i> Tổng quan
                    </a>
                    <a href="admin_appointment.aspx" class="nav-item">
                        <i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn
                    </a>
                    <a href="admin_customer.aspx" class="nav-item">
                        <i class="fa-solid fa-users"></i> Quản lý khách hàng
                    </a>
                    <a href="admin_staff.aspx" class="nav-item active">
                        <i class="fa-solid fa-user-tie"></i> Quản lý nhân sự
                    </a>
                    <a href="admin_service.aspx" class="nav-item">
                        <i class="fa-solid fa-spa"></i> Quản lý dịch vụ
                    </a>
                </nav>
                <a href="../client/login.aspx" class="nav-item logout-item">
                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                </a>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <div class="page-title">Quản lý nhân sự</div>
                    <div class="page-time">
                        <i class="fa-solid fa-clock"></i> 
                        <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %>
                    </div>
                </div>

                <div class="action-bar">
                    <div class="search-section">
                        <div class="search-wrapper">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="txt-search" 
                                         placeholder="Tìm kiếm nhân sự theo tên hoặc SĐT" 
                                         AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        </div>
                        <!-- ✅ SỬA: Dùng LinkButton để icon hiển thị đúng -->
                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search" 
                                        OnClick="btnSearch_Click">
                            <i class="fa-solid fa-search"></i> Tìm kiếm
                        </asp:LinkButton>
                    </div>
                    <a href="admin_staff_add.aspx" class="btn-add">
                        <i class="fa-solid fa-plus"></i> Thêm nhân sự
                    </a>
                </div>

                <div class="table-container">
                    <asp:Repeater ID="rptStaff" runat="server">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th><i class="fa-solid fa-user"></i> Họ và tên</th>
                                        <th><i class="fa-solid fa-phone"></i> Số điện thoại</th>
                                        <th><i class="fa-solid fa-briefcase"></i> Chức vụ</th>
                                        <th><i class="fa-solid fa-clock"></i> Ca làm việc</th>
                                        <th><i class="fa-solid fa-circle-dot"></i> Trạng thái</th>
                                        <th><i class="fa-solid fa-cogs"></i> Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><strong><%# Eval("ho_ten") %></strong></td>
                                <td><%# Eval("sdt") %></td>
                                <td><strong><%# Eval("chuc_vu") %></strong></td>
                                <td><%# Eval("ca_lam") %></td>
                                <td>
                                    <span class='<%# GetStatusClass(Eval("trang_thai")) %>'>
                                        <%# Eval("trang_thai") ?? "Chưa xác định" %>
                                    </span>
                                </td>
                                <td>
                                    <a href='admin_staff_detail.aspx?id=<%# Eval("id") %>' class="btn-detail">
                                        <i class="fa-solid fa-circle-info"></i> Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="no-data">
                        <i class="fa-solid fa-users-slash"></i>
                        Không tìm thấy nhân sự nào
                    </asp:Panel>
                </div>
            </main>
        </div>
    </form>
</body>
</html>