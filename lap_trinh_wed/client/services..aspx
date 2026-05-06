<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="services.aspx.cs" Inherits="lap_trinh_wed.client.services" %>

<!doctype html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa</title>
    <!-- FIX: Dùng ResolveUrl để CSS load đúng trong môi trường ASP.NET -->
   <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
</head>

<body class="bg-gray-50">
    <form id="form1" runat="server">
        <!-- Header: Giữ nguyên cấu trúc -->
        <header class="site-header">
            <div class="container header-inner">
                <a class="logo" href="Default.aspx" aria-label="Trang chủ Lily Spa">
                    <span class="logo-text">Lily Spa</span>
                </a>

                <nav class="site-nav" aria-label="Điều hướng">
                    <a href="Default.aspx" class="nav-link">Trang chủ</a>
                    <a href="services.aspx" class="nav-link">Dịch vụ làm đẹp</a>
                    <a href="booking.aspx" class="nav-link">Đặt lịch</a>
                    <a href="services.aspx" class="nav-link">Mã khuyến mãi</a>
                    <a href="login.aspx" class="nav-link">Tài khoản</a>
                </nav>

                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon" aria-hidden="true"></i>
                    <span class="header-greeting"><%= userGreeting %></span>
                </div>
            </div>
        </header>

        <!-- Hero / Banner Section -->
        <section class="hero">
            <div class="container">
                <div class="hero-banner">
                    <h1 class="hero-title">Chăm sóc sắc đẹp</h1>
                    <h2 class="hero-subtitle">Đặt lịch ngay hôm nay</h2>
                    <p class="hero-desc">Trải nghiệm dịch vụ spa cao cấp với hệ thống đặt lịch tiện lợi, nhanh chóng và đáng tin cậy</p>
                    <div class="hero-actions">
                        <a class="hero-btn hero-btn-primary" href="booking.aspx">Đặt lịch ngay</a>
                        <a class="hero-btn hero-btn-secondary" href="#services-list">Xem Dịch vụ</a>
                    </div>
                </div>
                <div class="services-anchor-title">Dịch vụ làm đẹp</div>
            </div>
        </section>

        <!-- Main Content: Filter và Grid 8 Dịch vụ[cite: 7] -->
        <section class="services" id="services-list">
            <div class="container">
                <div class="bg-white border border-gray-200 rounded-3xl p-5 md:p-6">
                    <!-- Filter Section (6 nút theo mẫu)[cite: 7] -->
                    <div class="flex flex-wrap gap-3 items-center mb-6">
                        <div class="relative flex-1 max-w-md min-w-[220px]">
                            <input type="text" id="search-input" placeholder="Tìm Kiếm dịch vụ" class="w-full pl-12 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500" />
                            <i class="fa-solid fa-magnifying-glass absolute left-5 top-1/2 -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <button type="button" class="px-6 py-3 bg-gray-100 border border-gray-300 rounded-2xl text-sm font-medium text-gray-700">Tất cả</button>
                        <button type="button" class="px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700">Chăm sóc da</button>
                        <button type="button" class="px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700">Massage</button>
                        <button type="button" class="px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700">Body</button>
                        <button type="button" class="px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700">Trị liệu</button>
                        <button type="button" class="px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700">combo</button>
                    </div>

                    <!-- Services Grid: Đầy đủ 8 dịch vụ[cite: 7] -->
                    <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-4 gap-4 md:gap-6">
                        <!-- 1. Collagen Glow -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/cham_soc_da_mat_Collagen_Glow.jpg") %>" class="service-item__img" alt="Collagen Glow" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Chăm Sóc Da Mặt Collagen Glow</h3>
                                <p class="service-item__desc">1.200.000 đ • 60 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 2. Massage Thư Giãn -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Massage_thu_gian_toan_than.jpg") %>" class="service-item__img" alt="Massage" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Massage Thư Giãn Toàn Thân</h3>
                                <p class="service-item__desc">800.000 đ • 90 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 3. Trị Mụn -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Dieu_tri_mun.jpg") %>" class="service-item__img" alt="Trị Mụn" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Trị Mụn Chuyên Sâu</h3>
                                <p class="service-item__desc">1.500.000 đ • 75 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 4. Body Detox -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Body_Detox_Tan_Mo.jpg") %>" class="service-item__img" alt="Body Detox" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Body Detox & Tắm Tỏa</h3>
                                <p class="service-item__desc">1.000.000 đ • 60 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 5. Vitamin C -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Facial_Duong_Trang_Vitamin_C.jpg") %>" class="service-item__img" alt="Vitamin C" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Facial Dưỡng Trắng Vitamin C</h3>
                                <p class="service-item__desc">950.000 đ • 45 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 6. Vai gáy -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Massage_chan_Vai_gay.jpg") %>" class="service-item__img" alt="Massage" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Massage Chân & Vai Gáy</h3>
                                <p class="service-item__desc">500.000 đ • 30 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 7. VIP 2-in-1 -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Package_VIP_2_in_1.jpg") %>" class="service-item__img" alt="VIP" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Package VIP 2-In-1</h3>
                                <p class="service-item__desc">2.500.000 đ • 120 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>

                        <!-- 8. Trị Nám -->
                        <a href="service-detail.aspx" class="service-item">
                            <div class="service-item__img-wrapper">
                                <img src="<%= ResolveUrl("~/assets/anh/Tri_nam_Laser_Q_Switch.jpg") %>" class="service-item__img" alt="Trị Nám" />
                            </div>
                            <div class="service-item__content">
                                <h3 class="service-item__title">Trị Nám Laser Q-Switch</h3>
                                <p class="service-item__desc">2.000.000 đ • 45 phút</p>
                                <span class="service-item__cta block text-center">ĐẶT LỊCH NGAY</span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer: Đúng chuẩn địa chỉ Phương Bình Công[cite: 7] -->
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
                                <a class="social-btn social-google" href="#" aria-label="Google"><i class="fa-brands fa-google"></i></a>
                                <p class="footer-connect__text">Nhóm 3.com</p>
                            </div>
                            <div class="footer-connect-item">
                                <a class="social-btn social-facebook" href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
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