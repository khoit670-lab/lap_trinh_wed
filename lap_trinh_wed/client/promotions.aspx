<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="promotions.aspx.cs" Inherits="lap_trinh_wed.client.promotions" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        .voucher-card {
            background: white;
            border: 1px solid #eee;
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
        }
        .voucher-card:hover { transform: translateY(-5px); }
        .voucher-image {
            background: #fff5f5;
            padding: 20px;
            text-align: center;
            border-bottom: 2px dashed #eee;
            position: relative;
        }
        /* Tạo hiệu ứng khía răng cưa 2 bên cho giống voucher thật */
        .voucher-image::before, .voucher-image::after {
            content: '';
            position: absolute;
            bottom: -10px;
            width: 20px;
            height: 20px;
            background: #f9fafb; /* khớp với bg xám của main */
            border-radius: 50%;
        }
        .voucher-image::before { left: -10px; }
        .voucher-image::after { right: -10px; }

        .filter-btn {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 8px 25px;
            font-weight: 600;
            background: white;
        }
        .filter-btn.active { background: #4a4a4a; color: white; border-color: #4a4a4a; }
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        
        <header class="site-header">
            <div class="container header-inner">
                <a class="logo" href="Default.aspx"><span class="logo-text">Lily Spa</span></a>
                <nav class="site-nav">
                    <a href="Default.aspx" class="nav-link">Trang chủ</a>
                    <a href="services.aspx" class="nav-link">Dịch vụ làm đẹp</a>
                    <a href="booking.aspx" class="nav-link">Đặt lịch</a>
                    <a href="promotions.aspx" class="nav-link active">Mã khuyến mãi</a>
                    <a href="login.aspx" class="nav-link">Tài khoản</a>
                </nav>
                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon"></i>
                    <span class="header-greeting"><%= userGreeting %></span>
                </div>
            </div>
        </header>

        <section class="hero" style="background-color: #f04581; padding: 60px 0; color: white; text-align: center;">
            <div class="container">
                <h1 class="text-4xl font-bold mb-2">Giảm đến 40% cho toàn bộ gói chăm sóc da</h1>
                <p class="text-lg opacity-90">Dành riêng cho thành viên Vàng & Bạc • Hạn đến 30/04/2026</p>
                <button class="mt-6 bg-white text-[#f04581] font-bold py-3 px-8 rounded-lg shadow-lg">Nhận Ngay Ưu Đãi</button>
            </div>
        </section>

        <main class="container mx-auto px-4 py-12">
            <div class="flex flex-wrap gap-4 mb-12 justify-center">
                <button type="button" class="filter-btn active">Tất cả</button>
                <button type="button" class="filter-btn">Đang áp dụng</button>
                <button type="button" class="filter-btn">Thành viên</button>
                <button type="button" class="filter-btn">Sắp hết hạn</button>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 max-w-6xl mx-auto">
                
                <div class="voucher-card">
                    <div class="voucher-image">
                        <img src="https://img.icons8.com/color/96/gift-card.png" class="mx-auto h-20" />
                        <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <h4 class="font-bold text-gray-800 text-sm">Giảm 30% gói Facial Collagen Glow</h4>
                                <span class="text-pink-500 font-bold">30%</span>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">Áp dụng cho tất cả dịch vụ chăm sóc da mặt</p>
                        </div>
                        <div class="flex justify-between items-center mt-6 border-t pt-4">
                            <div><p class="text-[10px] text-gray-400">Mã: <span class="font-bold text-pink-600">COLLAGEN30</span></p></div>
                            <button class="bg-pink-500 text-white text-[10px] font-bold px-3 py-2 rounded-lg">NHẬN ƯU ĐÃI</button>
                        </div>
                    </div>
                </div>

                <div class="voucher-card">
                    <div class="voucher-image">
                        <img src="https://img.icons8.com/color/96/ticket.png" class="mx-auto h-20" />
                        <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <h4 class="font-bold text-gray-800 text-sm">Tặng 30 phút Massage chân miễn phí</h4>
                                <span class="text-pink-500 font-bold">Tặng</span>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">Khi đặt bất kỳ gói Body nào</p>
                        </div>
                        <div class="flex justify-between items-center mt-6 border-t pt-4">
                            <div><p class="text-[10px] text-gray-400">Mã: <span class="font-bold text-pink-600">COLLAGEN30</span></p></div>
                            <button class="bg-pink-700 text-white text-[10px] font-bold px-3 py-2 rounded-lg">SỬ DỤNG NGAY</button>
                        </div>
                    </div>
                </div>

                <div class="voucher-card">
                    <div class="voucher-image">
                        <img src="https://img.icons8.com/color/96/coupon.png" class="mx-auto h-20" />
                        <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <h4 class="font-bold text-gray-800 text-sm">Giảm 40% toàn bộ dịch vụ Massage & Body</h4>
                                <span class="text-pink-500 font-bold">30%</span>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">Dành riêng cho thành viên hạng Vàng</p>
                        </div>
                        <div class="flex justify-between items-center mt-6 border-t pt-4">
                            <div><p class="text-[10px] text-gray-400">Mã: <span class="font-bold text-pink-600">GOLD40</span></p></div>
                            <button class="bg-pink-500 text-white text-[10px] font-bold px-3 py-2 rounded-lg">NHẬN ƯU ĐÃI</button>
                        </div>
                    </div>
                </div>

                <div class="voucher-card">
                    <div class="voucher-image">
                        <img src="https://img.icons8.com/color/96/label.png" class="mx-auto h-20" />
                        <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <h4 class="font-bold text-gray-800 text-sm">Combo Facial + Massage chỉ 1.599.000đ</h4>
                                <span class="text-pink-500 font-bold">Combo</span>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">Áp dụng cho tất cả dịch vụ chăm sóc da mặt</p>
                        </div>
                        <div class="flex justify-between items-center mt-6 border-t pt-4">
                            <div><p class="text-[10px] text-gray-400">Mã: <span class="font-bold text-pink-600">COMBO1599</span></p></div>
                            <button class="bg-pink-700 text-white text-[10px] font-bold px-3 py-2 rounded-lg">LƯU VOUCHER</button>
                        </div>
                    </div>
                </div>

                <div class="voucher-card">
                    <div class="voucher-image">
                        <img src="https://img.icons8.com/color/96/sparkling.png" class="mx-auto h-20" />
                        <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <h4 class="font-bold text-gray-800 text-sm">Giảm 30% Trị mụn chuyên sâu</h4>
                                <span class="text-pink-500 font-bold">30%</span>
                            </div>
                            <p class="text-xs text-gray-500 mt-2">Áp dụng cho tất cả dịch vụ chăm sóc da mặt</p>
                        </div>
                        <div class="flex justify-between items-center mt-6 border-t pt-4">
                            <div><p class="text-[10px] text-gray-400">Mã: <span class="font-bold text-pink-600">COLLAGEN33</span></p></div>
                            <button class="bg-pink-500 text-white text-[10px] font-bold px-3 py-2 rounded-lg">NHẬN ƯU ĐÃI</button>
                        </div>
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
                            <div class="footer-connect-item"><a class="social-btn" href="#"><i class="fa-brands fa-google"></i></a><p class="footer-connect__text">Nhóm 3.com</p></div>
                            <div class="footer-connect-item"><a class="social-btn" href="#"><i class="fa-brands fa-facebook-f"></i></a><p class="footer-connect__text">Chăm sóc sắc đẹp Lily Spa</p></div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>