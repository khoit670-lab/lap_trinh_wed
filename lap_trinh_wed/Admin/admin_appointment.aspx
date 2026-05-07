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

        /* SIDEBAR (Giữ nguyên từ trang trước) */
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

        /* NỘI DUNG CHÍNH */
        .main-content { margin-left: 350px; padding: 80px 60px; width: 100%; }
        .main-content h1 { font-size: 50px; margin-bottom: 40px; font-weight: bold; text-align: center; }

        /* NÚT BẤM LỌC (Filter Buttons) */
        .filter-container { display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap; }
        .btn-filter {
            padding: 12px 25px; border-radius: 15px; border: 1.5px solid #ccc;
            background: #fff; font-weight: bold; cursor: pointer; font-size: 16px; transition: 0.3s;
        }
        .btn-filter.active { background: #fff0f3; border-color: #f04581; }
        .btn-filter:hover { background: #f9f9f9; }

        /* BẢNG DỮ LIỆU (Table) */
        .table-container {
            background: #fff; border: 1.5px solid #333; border-radius: 25px;
            overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fff; padding: 25px 20px; text-align: left; font-size: 20px; border-bottom: 2px solid #000; }
        td { padding: 25px 20px; font-size: 17px; color: #444; border-bottom: 1px solid #eee; vertical-align: middle; }
        
        .action-link { color: #f04581; text-decoration: none; font-weight: bold; }
        .action-link:hover { text-decoration: underline; }

        .bg-footer-text { font-size: 50px; color: #f2f2f2; font-weight: bold; margin-top: auto; line-height: 1.2; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <aside class="sidebar">
                <div class="logo-box">
                    <div class="logo-circle"><img src="../assets/anh/logo.png" alt="Logo" /></div>
                    <div class="logo-text"><h2>Lily Spa</h2><span>Quản trị viên</span></div>
                </div>
                <nav class="nav-menu">
                    <a href="admin_dashboard.aspx" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
                    <a href="#" class="nav-item active"><i class="fa-solid fa-calendar-check"></i> Quản lý lịch hẹn</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-users"></i> Quản lý khách hàng</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-user-tie"></i> Quản lý nhân sự</a>
                    <a href="#" class="nav-item"><i class="fa-solid fa-spa"></i> Quản lý dịch vụ</a>
                </nav>
                <div class="bg-footer-text">Quản lý<br>lịch hẹn</div>
            </aside>

            <main class="main-content">
                <h1>Quản lý lịch hẹn</h1>
                
                <div class="filter-container">
                    <button type="button" class="btn-filter active">Tất cả</button>
                    <button type="button" class="btn-filter">Chờ xác nhận</button>
                    <button type="button" class="btn-filter">Đã xác nhận</button>
                    <button type="button" class="btn-filter">Hoàn thành</button>
                    <button type="button" class="btn-filter">Đã hủy</button>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Thời gian</th>
                                <th>Khách hàng</th>
                                <th>Dịch vụ</th>
                                <th>Nhân viên</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>16/04/2026<br>-10:00</td>
                                <td>ABCDFFF</td>
                                <td>Chăm sóc da<br>Collagen Glow</td>
                                <td>Chị Lan</td>
                                <td>Đã xác nhận</td>
                                <td><a href="#" class="action-link">Chi tiết</a></td>
                            </tr>
                            <tr>
                                <td>16/04/2026<br>-10:00</td>
                                <td>ABCDFF</td>
                                <td>Massage thư giãn<br>toàn thân</td>
                                <td>Chị Lan</td>
                                <td>Đã xác nhận</td>
                                <td><a href="#" class="action-link">Chi tiết</a></td>
                            </tr>
                            <tr>
                                <td>16/04/2026<br>-10:00</td>
                                <td>ABCDFF</td>
                                <td>Body Detox<br>& Tan Mỡ</td>
                                <td>Chị Lan</td>
                                <td>Đã xác nhận</td>
                                <td><a href="#" class="action-link">Chi tiết</a></td>
                            </tr>
                            <tr>
                                <td>16/04/2026<br>-10:00</td>
                                <td>ABCDFF</td>
                                <td>Chăm sóc da<br>Collagen Glow</td>
                                <td>Chị Lan</td>
                                <td>Đã xác nhận</td>
                                <td><a href="#" class="action-link">Chi tiết</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </form>
</body>
</html>