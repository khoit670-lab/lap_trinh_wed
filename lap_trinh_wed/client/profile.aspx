<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="lap_trinh_wed.client.profile" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa - Tài Khoản</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* CSS bổ sung để đảm bảo layout tách rời và đẹp mắt */
        .profile-section {
            padding: 40px 0 80px 0; /* Tạo khoảng cách trên dưới cho phần content */
            background-color: #f9f9f9;
        }
        
        /* Hiệu ứng cho các khối nội dung giống mẫu ảnh bạn gửi */
        .content-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }

        /* Tùy chỉnh Banner để không bị dính vào content */
        .hero-custom {
            background-color: #f04581;
            padding: 60px 0;
            text-align: center;
            color: white;
        }
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        
        <header class="site-header">
            <div class="container header-inner">
                <a class="logo" href="Default.aspx">
                    <span class="logo-text">Lily Spa</span>
                </a>
                <nav class="site-nav">
                    <a href="Default.aspx" class="nav-link">Trang chủ</a>
                    <a href="services.aspx" class="nav-link">Dịch vụ làm đẹp</a>
                    <a href="booking.aspx" class="nav-link">Đặt lịch</a>
                    <a href="services.aspx" class="nav-link">Mã khuyến mãi</a>
                    <a href="profile.aspx" class="nav-link active">Tài khoản</a>
                </nav>
                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon"></i>
                    <span class="header-greeting"><%= userGreeting %></span>
                </div>
            </div>
        </header>

        <section class="hero-custom">
            <div class="container">
                <h1 class="text-4xl font-bold mb-2 uppercase tracking-wide">Hồ sơ của bạn</h1>
                <p class="text-lg opacity-90">Quản lý thông tin và lịch hẹn tại Lily Spa</p>
            </div>
        </section>

        <main class="profile-section">
            <div style="max-width: 1000px; margin: 0 auto; padding: 0 15px; font-family: Arial, sans-serif;">
                
                <div style="background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 25px; display: flex; align-items: center; gap: 30px; margin-bottom: 20px;">
                    <div style="width: 100px; height: 100px; border: 1px solid #f0f0f0; border-radius: 10px; flex-shrink: 0; background: #fafafa; display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-user" style="color: #ddd; font-size: 40px;"></i>
                    </div>
                    
                    <div style="flex-grow: 1;">
                        <h2 style="margin: 0 0 5px 0; font-size: 20px; color: #333;"><asp:Literal ID="ltrName" runat="server">ABC</asp:Literal></h2>
                        <p style="margin: 0; font-size: 12px; color: #999;">0989710XXX - K@gmail.com</p>
                        
                        <div style="display: flex; align-items: center; gap: 20px; margin-top: 15px;">
                            <div style="background: #ffb400; color: #fff; padding: 10px 15px; border-radius: 12px; text-align: center; min-width: 110px;">
                                <span style="font-size: 9px; display: block; text-transform: uppercase; margin-bottom: 2px;">Hạng Thành viên</span>
                                <span style="font-size: 24px; font-weight: bold;">Vàng</span>
                            </div>
                            
                            <div style="flex-grow: 1;">
                                <div style="display: flex; justify-content: space-between; font-size: 11px; color: #999; margin-bottom: 6px;">
                                    <span>0989710XXX - K@gmail.com</span>
                                    <span>1200/2150</span>
                                </div>
                                <div style="height: 10px; background: #f0f0f0; border-radius: 10px; overflow: hidden;">
                                    <div style="width: 60%; height: 100%; background: #ffb400;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h3 style="font-size: 15px; color: #444; font-weight: bold; margin: 25px 0 12px 5px;">Lịch hẹn sắp tới</h3>
                <div style="background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 25px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <div style="display: flex; align-items: center; gap: 30px;">
                        <div style="text-align: center; border-right: 1px solid #f5f5f5; padding-right: 30px;">
                            <span style="display: block; font-size: 48px; font-weight: bold; color: #f04581; line-height: 1;">16</span>
                            <span style="font-size: 11px; color: #999; font-weight: bold;">Tháng 4</span>
                            <span style="display: block; font-size: 18px; font-weight: bold; color: #333;">2026</span>
                        </div>
                        <div>
                            <p style="margin: 0; font-weight: bold; color: #333; font-size: 15px;">10:00 - Chăm sóc da mặt Collagen Glow</p>
                            <p style="margin: 6px 0 0 0; font-size: 12px; color: #999;">Kỹ thuật viên: Chị Lan • Phòng 02</p>
                        </div>
                    </div>
                    <div style="display: flex; gap: 12px;">
                        <button type="button" style="padding: 10px 22px; border: 1px solid #ffccd5; color: #ff94a2; background: none; border-radius: 10px; cursor: pointer; font-size: 13px;">Hủy lịch</button>
                        <button type="button" style="padding: 10px 28px; background: #f04581; color: #fff; border: none; border-radius: 10px; font-weight: bold; cursor: pointer; font-size: 13px;">ĐỔI GIỜ</button>
                    </div>
                </div>

                <h3 style="font-size: 15px; color: #444; font-weight: bold; margin: 25px 0 12px 5px;">Lịch sử dịch vụ</h3>
                <div style="background: #fff; border: 1px solid #eee; border-radius: 15px; overflow: hidden; margin-bottom: 20px;">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead style="background: #fafafa; color: #999; font-size: 11px; text-transform: uppercase;">
                            <tr>
                                <th style="padding: 18px 20px;">Ngày</th>
                                <th style="padding: 18px 20px;">Dịch vụ</th>
                                <th style="padding: 18px 20px;">Giá</th>
                                <th style="padding: 18px 20px;">Kỹ thuật viên</th>
                                <th style="padding: 18px 20px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody style="font-size: 14px; color: #444;">
                            <tr style="border-top: 1px solid #f5f5f5;">
                                <td style="padding: 20px;">10/04/2026</td>
                                <td style="padding: 20px; font-weight: bold;">Massage thư giãn toàn thân</td>
                                <td style="padding: 20px; font-weight: bold; color: #000;">800.000 đ</td>
                                <td style="padding: 20px;">Ngọc khang</td>
                                <td style="padding: 20px;"><a href="#" style="color: #ffb6c1; text-decoration: none;">Đặt lại</a></td>
                            </tr>
                            <tr style="border-top: 1px solid #f5f5f5;">
                                <td style="padding: 20px;">10/04/2026</td>
                                <td style="padding: 20px; font-weight: bold;">Chăm số da</td>
                                <td style="padding: 20px; font-weight: bold; color: #000;">600.000 đ</td>
                                <td style="padding: 20px;">Ngọc khang</td>
                                <td style="padding: 20px;"><a href="#" style="color: #ffb6c1; text-decoration: none;">Đặt lại</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <h3 style="font-size: 15px; color: #444; font-weight: bold; margin: 25px 0 12px 5px;">Ưu đãi</h3>
                <div style="display: flex; gap: 15px; margin-bottom: 30px;">
                    <div style="flex: 1; border: 1px solid #ffe4e8; border-radius: 15px; padding: 22px; background: #fff;">
                        <p style="margin: 0; color: #f04581; font-weight: bold; font-size: 15px;">SPA20OFF</p>
                        <p style="margin: 6px 0 0 0; color: #999; font-size: 12px;">Giảm 20% cho lần đặt lịch tiếp theo</p>
                    </div>
                    <div style="flex: 1; border: 1px solid #ffe4e8; border-radius: 15px; padding: 22px; background: #fff;">
                        <p style="margin: 0; color: #f04581; font-weight: bold; font-size: 15px;">FREEMASSAGE</p>
                        <p style="margin: 6px 0 0 0; color: #999; font-size: 12px;">Tặng 30 phút massage chân khi đặt gói Facial</p>
                    </div>
                </div>
            </div>
        </main>

        <footer class="footer">
            <div class="container">
                <div class="footer-box">
                    <div class="footer-col">
                        <h3 class="footer-title">Thông tin liên hệ</h3>
                        <div class="footer-lines">
                            <p><i class="fa-solid fa-location-dot"></i> 96 - Phương Bình Công Thành Phố Ba Đình, Hà Nội</p>
                            <p><i class="fa-solid fa-phone"></i> 18001508 (CSKH)</p>
                            <p><i class="fa-solid fa-phone"></i> 099999999 (Tư vấn viên)</p>
                            <p><i class="fa-regular fa-clock"></i> Thời gian làm việc: từ 8h30 đến 22h00</p>
                        </div>
                    </div>
                    <div class="footer-col">
                        <h3 class="footer-title">Kết nối</h3>
                        <div class="footer-connect">
                            <div class="footer-connect-item">
                                <a class="social-btn social-google" href="#"><i class="fa-brands fa-google"></i></a>
                                <p class="footer-connect__text">Nhóm 3.com</p>
                            </div>
                            <div class="footer-connect-item">
                                <a class="social-btn social-facebook" href="#"><i class="fa-brands fa-facebook-f"></i></a>
                                <p class="footer-connect__text">Chăm sóc sắc đẹp Lily Spa</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>