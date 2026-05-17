<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_appointment.aspx.cs" Inherits="lap_trinh_wed.admin.appointment" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Quản lý lịch hẹn</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fcfcfc; }
        .wrapper { display: flex; }

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
        .nav-item.active { background-color: #fff0f3; color: #000; }
        .nav-item:hover:not(.active) { background-color: #f9f9f9; }

        .main-content { margin-left: 350px; padding: 80px 60px; width: 100%; }
        .main-content h1 { font-size: 50px; margin-bottom: 40px; font-weight: bold; text-align: center; }

        .filter-container { display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap; }
        .btn-filter {
            padding: 12px 25px; border-radius: 25px; border: 2px solid #ddd;
            background: #fff; font-weight: bold; cursor: pointer; font-size: 16px; 
            transition: all 0.3s; box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .btn-filter.active { background: #f04581; color: white; border-color: #f04581; }
        .btn-filter:hover:not(.active) { background: #f9f9f9; transform: translateY(-1px); }

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
        
        .status-badge {
            padding: 6px 12px; border-radius: 20px; font-size: 14px; font-weight: bold;
            color: white; text-align: center; min-width: 100px;
        }
        .status-cho { background: #ff9800; }
        .status-xac { background: #4caf50; }
        .status-dang { background: #8b5cf6; }
        .status-hoan { background: #2196f3; }
        .status-huy { background: #f44336; }

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
                        <img src="../assets/anh/logo.png" alt="Logo" onerror="this.innerHTML='LS'" />
                    </div>
                    <div class="logo-text">
                        <h2>Lily Spa</h2>
                        <span runat="server" id="lblUserGreeting">Quản trị viên</span>
                    </div>
                </div>
                <nav class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
                    <a href="admin_appointment.aspx" class="nav-item active"><i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn</a>
                    <a href="admin_customer.aspx" class="nav-item"><i class="fa-solid fa-users"></i> Quản lý khách hàng</a>
                    <a href="admin_staff.aspx" class="nav-item"><i class="fa-solid fa-user-tie"></i> Quản lý nhân sự</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
                </nav>
            </aside>
             
            <main class="main-content">
                <h1>📅 Quản lý lịch hẹn</h1>
                
                <!-- Filter Buttons -->
                <div class="filter-container">
                    <asp:Button ID="btnTatCa" runat="server" CssClass="btn-filter active" Text="Tất cả" 
                               OnClick="btnTatCa_Click" />
                    <asp:Button ID="btnChoXacNhan" runat="server" CssClass="btn-filter" Text="Chờ xác nhận" 
                               OnClick="btnChoXacNhan_Click" />
                    <asp:Button ID="btnDaXacNhan" runat="server" CssClass="btn-filter" Text="Đã xác nhận" 
                               OnClick="btnDaXacNhan_Click" />
                    <asp:Button ID="btnHoanThanh" runat="server" CssClass="btn-filter" Text="Hoàn thành" 
                               OnClick="btnHoanThanh_Click" />
                    <asp:Button ID="btnHuy" runat="server" CssClass="btn-filter" Text="Hủy" 
                               OnClick="btnHuy_Click" />
                </div>

                <!-- Table -->
                <div class="table-container">
                    <asp:Repeater ID="rptAppointments" runat="server" OnItemDataBound="rptAppointments_ItemDataBound">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Thời gian</th>
                                        <th>Mã KH</th>
                                        <th>Khách hàng</th>
                                        <th>Dịch vụ</th>
                                        <th>Nhân viên</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Eval("ngay_hen", "{0:dd/MM/yyyy}") %><br>
                                    <strong><%# Eval("gio_hen") %></strong>
                                </td>
                                <td><strong><%# Eval("ma_khach_hang") %></strong></td>
                                <td><%# Eval("ten_khach_hang") %></td>
                                <td><%# Eval("dich_vu")?.ToString().Replace(", ", "<br>") ?? "Chưa có" %></td>
                                <td><%# Eval("ten_nhan_su") ?? "Chưa phân" %></td>
                                <td>
                                    <span class='status-badge status-<%# GetStatusClass(Eval("trang_thai").ToString()) %>'>
                                        <%# Eval("trang_thai") %>
                                    </span>
                                </td>
                                <td>
                                    <!-- ✅ ĐÃ SỬA: id thay vì maLH -->
                                    <a href='admin_appointment_detail.aspx?id=<%# Eval("id") %>' class="action-link">
                                        <i class="fa-solid fa-eye"></i> Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody></table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlNoData" runat="server" CssClass="no-data" Visible="false">
                        <i class="fa-solid fa-calendar-xmark" style="font-size: 64px; color: #ddd; margin-bottom: 20px;"></i>
                        <div>Không có lịch hẹn nào</div>
                    </asp:Panel>
                </div>
            </main>
        </div>
    </form>
</body>
</html>