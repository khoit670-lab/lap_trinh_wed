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

        /* Sidebar - Đồng bộ với dashboard/staff */
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
        .nav-item.active { background-color: #fff0f3; color: #f04581; }
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
            border-bottom: 1px solid #f5f5f5; vertical-align: middle;
        }
        tr:hover td { background-color: #fff5f8; }
        
        .service-img { 
            width: 60px; height: 60px; border-radius: 12px; object-fit: cover; 
            border: 2px solid #f0f0f0; 
        }
        .service-img-placeholder {
            width: 60px; height: 60px; border-radius: 12px; border: 2px solid #ffcad4;
            background: linear-gradient(135deg, #fff5f8, #ffeef2); 
            display: flex; align-items: center; justify-content: center;
            font-size: 24px; color: #f04581;
        }
        
        .btn-detail, .btn-edit, .btn-delete { 
            padding: 8px 16px; border-radius: 20px; font-weight: bold; 
            text-decoration: none; margin-right: 8px; font-size: 14px; 
            display: inline-flex; align-items: center; gap: 6px; transition: 0.3s;
        }
        .btn-detail { 
            color: #f04581; border: 2px solid #f04581; 
        }
        .btn-detail:hover { background: #f04581; color: white; }
        .btn-edit { 
            color: #52c41a; border: 2px solid #52c41a; 
        }
        .btn-edit:hover { background: #52c41a; color: white; }
        .btn-delete { 
            color: #ff4d4f; border: 2px solid #ff4d4f; 
        }
        .btn-delete:hover { background: #ff4d4f; color: white; }

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
                    <a href="admin_staff.aspx" class="nav-item">
                        <i class="fa-solid fa-user-tie"></i> Quản lý nhân sự
                    </a>
                    <a href="admin_service.aspx" class="nav-item active">
                        <i class="fa-solid fa-spa"></i> Quản lý dịch vụ
                    </a>
                </nav>
                <a href="../client/login.aspx" class="nav-item logout-item">
                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                </a>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <div class="page-title">Quản lý dịch vụ</div>
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
                                         placeholder="Tìm kiếm dịch vụ theo tên hoặc loại" 
                                         AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        </div>
                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search" 
                                        OnClick="btnSearch_Click">
                            <i class="fa-solid fa-search"></i> Tìm kiếm
                        </asp:LinkButton>
                    </div>
                    <a href="admin_service_add.aspx" class="btn-add">
                        <i class="fa-solid fa-plus"></i> Thêm dịch vụ
                    </a>
                </div>

                <div class="table-container">
                    <asp:Repeater ID="rptServices" runat="server">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                               
                                        <th><i class="fa-solid fa-tag"></i> Tên dịch vụ</th>
                                        <th><i class="fa-solid fa-list"></i> Loại</th>
                                        <th><i class="fa-solid fa-clock"></i> Thời gian</th>
                                        <th><i class="fa-solid fa-coins"></i> Giá tiền</th>
                                        <th><i class="fa-solid fa-cogs"></i> Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                
                                <td><strong><%# Eval("TenDichVu") %></strong></td>
                                <td><%# Eval("Loai") %></td>
                                <td><%# Eval("ThoiGian") %></td>
                                <td class="price"><strong><%# Eval("GiaTien") %></strong></td>
                                <td>
                                    <a href='admin_service_detail.aspx?id=<%# Eval("ID") %>' class="btn-detail">
                                        <i class="fa-solid fa-circle-info"></i> Chi tiết
                                    </a>
                                    <a href='admin_service_edit.aspx?id=<%# Eval("ID") %>' class="btn-edit">
                                        <i class="fa-solid fa-edit"></i> Sửa
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                                    CommandArgument='<%# Eval("ID") %>' CssClass="btn-delete" 
                                                    OnClientClick="return confirm('Xóa dịch vụ này?');"
                                                    ToolTip="Xóa dịch vụ">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="no-data">
                        <i class="fa-solid fa-spa"></i>
                        Không tìm thấy dịch vụ nào
                    </asp:Panel>
                </div>
            </main>
        </div>
    </form>
</body>
</html>