<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="lap_trinh_wed.admin.admin_dashboard" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #fcfcfc; }
        .wrapper { display: flex; }
        .sidebar { width: 350px; background: #fff; border-right: 1px solid #eee; display: flex; flex-direction: column; padding: 50px 30px; position: fixed; height: 100vh; }
        .logo-box { display: flex; align-items: center; gap: 20px; padding-bottom: 30px; border-bottom: 1px solid #f5f5f5; margin-bottom: 40px; }
        .logo-circle { width: 75px; height: 75px; border-radius: 50%; border: 1px solid #ddd; display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .logo-circle img { width: 85%; height: auto; }
        .logo-text h2 { font-size: 30px; font-weight: bold; }
        .nav-menu { display: flex; flex-direction: column; gap: 15px; flex-grow: 1; }
        .nav-item { text-decoration: none; color: #333; padding: 18px 25px; border-radius: 35px; font-size: 19px; font-weight: bold; display: flex; align-items: center; gap: 15px; transition: 0.3s; }
        .nav-item.active { background-color: #fff0f3; color: #f04581; }
        .logout-item { margin-top: auto; color: #ff4d4f !important; border-top: 1px solid #eee; padding-top: 25px !important; }
        .main-content { margin-left: 350px; padding: 80px 100px; width: 100%; }
        .dashboard-header { margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center; }
        .stats-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; max-width: 1200px; }
        .stat-card { background: #fff; border: 1.5px solid #eee; border-radius: 25px; padding: 40px; min-height: 200px; display: flex; flex-direction: column; justify-content: center; position: relative; box-shadow: 0 4px 10px rgba(0,0,0,0.02); }
        .stat-label { font-size: 18px; color: #888; font-weight: 500; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; }
        .stat-value { font-size: 48px; font-weight: bold; }
        .bg-icon { position: absolute; right: 30px; top: 30px; font-size: 60px; color: rgba(0,0,0,0.03); }
        .txt-green { color: #52c41a; }
        .txt-pink { color: #f04581; }
        .txt-red { color: #ff4d4f; }
        .stat-card .txt-green { color: #52c41a !important; }
        .stat-card .txt-pink { color: #f04581 !important; }
        .stat-card .txt-red { color: #ff4d4f !important; }
        .refresh-btn { padding: 10px 25px; background: #f04581; color: white; border: none; border-radius: 25px; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-box">
                    <div class="logo-circle"><img src="../assets/anh/logo.png" alt="Logo" /></div>
                    <div class="logo-text"><h2>Lily Spa</h2><span><%= userGreeting %></span></div>
                </div>
                <nav class="nav-menu">
    <a href="admin_dashboard.aspx" class="nav-item active"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
    <a href="admin_appointment.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn</a>
    <a href="admin_customer.aspx" class="nav-item"><i class="fa-solid fa-users"></i> Quản lý khách hàng</a>
    <a href="admin_staff.aspx" class="nav-item"><i class="fa-solid fa-user-tie"></i> Quản lý nhân sự</a>
    <a href="#" class="nav-item"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
</nav>
                <a href="../client/login.aspx" class="nav-item logout-item"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
            </aside>
            <main class="main-content">
                <div class="dashboard-header">
                    <div style="color: #888;"><i class="fa-solid fa-clock"></i> Cập nhật: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></div>
                    <asp:Button ID="btnRefresh" runat="server" CssClass="refresh-btn" Text="Làm mới" OnClick="btnRefresh_Click" />
                </div>
                <h1 style="font-size: 40px; margin-bottom: 40px;">Tổng quan hệ thống</h1>
                <div class="stats-grid">
                    <div class="stat-card">
                        <i class="fa-solid fa-users bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-address-book"></i> Tổng số khách hàng</span>
                        <div class="stat-value"><%= tongKhachHang %></div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-money-bill-trend-up bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-coins"></i> Doanh thu hôm nay</span>
                        <div class="stat-value txt-green"><%= doanhThuHomNay %></div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-calendar-day bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-clock"></i> Lịch hẹn hôm nay</span>
                        <div class="stat-value txt-pink"><%= lichHenHomNay %> Lịch</div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-user-plus bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-user-check"></i> Khách mới trong tháng</span>
                        <div class="stat-value txt-pink"><%= khachMoiTrongThang %> Khách</div>
                    </div>
                    <div class="stat-card" style="grid-column: span 2;">
                        <i class="fa-solid fa-user-slash bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-triangle-exclamation"></i> Tỉ lệ khách hủy hôm nay</span>
                        <div class="stat-value txt-red"><%= tyLeHuy %></div>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>