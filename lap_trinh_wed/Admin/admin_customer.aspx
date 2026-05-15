<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_customer.aspx.cs" Inherits="lap_trinh_wed.admin.admin_customer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Quản lý khách hàng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Kế thừa toàn bộ Style từ trang Quản lý lịch hẹn */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fcfcfc; }
        .wrapper { display: flex; }

        /* Sidebar */
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
        .main-content h1 { font-size: 50px; margin-bottom: 40px; font-weight: bold; text-align: center; }

        /* Search Bar kiểu Filter */
        .search-container { display: flex; gap: 15px; margin-bottom: 30px; }
        .search-input {
            flex: 1; padding: 15px 25px; border-radius: 30px; border: 2px solid #ddd;
            font-size: 16px; outline: none; box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .btn-search {
            padding: 12px 35px; border-radius: 30px; border: none;
            background: #f04581; color: white; font-weight: bold; cursor: pointer;
            font-size: 16px; transition: 0.3s;
        }
        .btn-search:hover { background: #d0356c; transform: translateY(-1px); }

        /* Table */
        .table-container {
            background: #fff; border-radius: 25px; overflow: hidden; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: 1px solid #eee;
        }
        table { width: 100%; border-collapse: collapse; }
        th { 
            background: linear-gradient(135deg, #f8f9fa 0%, #fff 100%); 
            padding: 25px 20px; text-align: left; font-size: 18px; font-weight: bold; 
            border-bottom: 3px solid #f04581; color: #333;
        }
        td { padding: 20px; font-size: 16px; color: #555; border-bottom: 1px solid #f0f0f0; vertical-align: middle; }
        tr:hover td { background: #fff5f8; }

        /* Badge phân hạng (giống Status Badge) */
        .rank-badge {
            padding: 6px 15px; border-radius: 20px; font-size: 14px; font-weight: bold;
            color: white; text-align: center; display: inline-block; min-width: 90px;
        }
        .rank-gold { background: #ff9800; } /* Vàng */
        .rank-silver { background: #9e9e9e; } /* Bạc */
        .rank-bronze { background: #795548; } /* Đồng */
        .rank-diamond { background: #2196f3; } /* Kim cương */

        .action-link { 
            color: #f04581; text-decoration: none; font-weight: bold; padding: 8px 16px;
            border: 2px solid #f04581; border-radius: 20px; transition: 0.3s;
        }
        .action-link:hover { background: #f04581; color: white; }
        
        .no-data { text-align: center; padding: 60px; color: #888; font-size: 18px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-box">
                    <div class="logo-circle">
                        <img src="../assets/anh/logo.png" alt="Logo" onerror="this.src='../assets/anh/default-logo.png'" />
                    </div>
                    <div class="logo-text">
                        <h2>Lily Spa</h2>
                        <span runat="server" id="lblUserRole">Quản trị viên</span>
                    </div>
                </div>
                <nav class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
                    <a href="admin_appointment.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn</a>
                    <a href="admin_customer.aspx" class="nav-item active"><i class="fa-solid fa-users"></i> Quản lý khách hàng</a>
                    <a href="admin_staff.aspx" class="nav-item"><i class="fa-solid fa-user-tie"></i> Quản lý nhân sự</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
                </nav>
            </aside>

            <main class="main-content">
                <h1>👥 Quản lý khách hàng</h1>

                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" 
                                 placeholder="Tìm kiếm theo tên khách hàng hoặc số điện thoại..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
                </div>

                <div class="table-container">
                    <asp:Repeater ID="rptCustomers" runat="server">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Khách hàng</th>
                                        <th>Số điện thoại</th>
                                        <th>Hạng thành viên</th>
                                        <th>Tổng chi tiêu</th>
                                        <th>Số lần hủy</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><strong><%# Eval("ho_va_ten") %></strong></td>
                                <td><%# Eval("so_dien_thoai") %></td>
                                <td>
                                    <span class='rank-badge <%# GetRankClass(Eval("tong_chi_tieu")) %>'>
                                        <%# GetRankName(Eval("tong_chi_tieu")) %>
                                    </span>
                                </td>
                                <td><strong style="color: #333;"><%# string.Format("{0:N0}đ", Eval("tong_chi_tieu")) %></strong></td>
                                <td><%# Eval("so_lan_huy") %></td>
                                <td>
                                    <a href='admin_customer_detail.aspx?id=<%# Eval("id") %>' class="action-link">
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

                    <asp:Panel ID="pnlNoData" runat="server" CssClass="no-data" Visible="false">
                        <i class="fa-solid fa-users-slash" style="font-size: 64px; color: #ddd; margin-bottom: 20px;"></i>
                        <div>Không tìm thấy khách hàng nào</div>
                    </asp:Panel>
                </div>
            </main>
        </div>
    </form>
</body>
</html>