<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="lap_trinh_wed.admin.dashboard" %>

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

        /* SIDEBAR */
        .sidebar {
            width: 350px; background: #fff; border-right: 1px solid #eee;
            display: flex; flex-direction: column; padding: 50px 30px;
            position: fixed; height: 100vh;
        }
        .logo-box { display: flex; align-items: center; gap: 20px; padding-bottom: 30px; border-bottom: 1px solid #f5f5f5; margin-bottom: 40px; }
        .logo-circle {
            width: 75px; height: 75px; border-radius: 50%; border: 1px solid #ddd;
            display: flex; align-items: center; justify-content: center; overflow: hidden;
        }
        .logo-circle img { width: 85%; height: auto; }
        .logo-text h2 { font-size: 30px; font-weight: bold; }

        /* MENU VỚI ICON */
        .nav-menu { display: flex; flex-direction: column; gap: 15px; flex-grow: 1; }
        .nav-item {
            text-decoration: none; color: #333; padding: 18px 25px; border-radius: 35px;
            font-size: 19px; font-weight: bold; display: flex; align-items: center; gap: 15px;
            transition: 0.3s;
        }
        .nav-item i { width: 25px; text-align: center; font-size: 22px; }
        .nav-item.active { background-color: #fff0f3; color: #000; }
        .nav-item:hover:not(.active) { background-color: #f9f9f9; }

        /* NỘI DUNG CHÍNH - Ô THỐNG KÊ LỚN */
        .main-content { margin-left: 350px; padding: 80px 100px; width: 100%; }
        .main-content h1 { font-size: 50px; margin-bottom: 60px; font-weight: bold; }

        .stats-grid { display: flex; flex-wrap: wrap; gap: 40px; max-width: 1400px; }

        .stat-card {
            background: #fff; border: 1.5px solid #ccc; border-radius: 25px;
            padding: 50px 40px; width: calc(50% - 20px); min-height: 240px;
            display: flex; flex-direction: column; justify-content: space-between;
            position: relative; overflow: hidden;
        }

        /* Icon mờ trang trí phía sau ô thống kê cho đẹp */
        .stat-card i.bg-icon {
            position: absolute; right: 20px; top: 20px;
            font-size: 80px; color: rgba(0,0,0,0.03);
        }

        .stat-label { font-size: 18px; color: #888; font-weight: 500; display: flex; align-items: center; gap: 10px; }
        .stat-value { font-size: 55px; font-weight: bold; }

        /* MÀU SẮC */
        .txt-green { color: #52c41a; }
        .txt-pink { color: #f04581; }
        .txt-red { color: #ff4d4f; }

        .bg-footer-text { font-size: 50px; color: #f2f2f2; font-weight: bold; margin-top: auto; line-height: 1.2; }
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
                        <span><%= userGreeting %></span>
                    </div>
                </div>

                <nav class="nav-menu">
                    <a href="#" class="nav-item active"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-users"></i> Quản lý khách hàng</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-user-tie"></i> Quản lý nhân sự</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
                </nav>

                <div class="bg-footer-text">Quản lý<br>lịch hẹn</div>
            </aside>

            <main class="main-content">
                <h1>Tổng quan</h1>
                <div class="stats-grid">
                    <div class="stat-card">
                        <i class="fa-solid fa-money-bill-trend-up bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-coins"></i> Doanh thu hôm nay</span>
                        <div class="stat-value txt-green">14.500.500 đ</div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-calendar-day bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-clock"></i> Lịch hẹn</span>
                        <div class="stat-value txt-pink">38 Khách hàng</div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-user-plus bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-user-check"></i> Khách hàng mới</span>
                        <div class="stat-value txt-pink">8 Khách hàng</div>
                    </div>
                    <div class="stat-card">
                        <i class="fa-solid fa-user-slash bg-icon"></i>
                        <span class="stat-label"><i class="fa-solid fa-triangle-exclamation"></i> Tỉ lệ khách hủy</span>
                        <div class="stat-value txt-red">1 Khách hàng</div>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>