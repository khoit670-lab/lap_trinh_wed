<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="lap_trinh_wed.client.Default" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="site-header">
            <div class="container header-inner">
                <a class="logo" href="Default.aspx">
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

        <section class="hero">
            <div class="container">
                <div class="hero-banner">
                    <h1 class="hero-title">Chăm sóc sắc đẹp</h1>
                    <h2 class="hero-subtitle">Đặt lịch ngay hôm nay</h2>
                    <p class="hero-desc">
                        Trải nghiệm dịch vụ spa cao cấp với hệ thống đặt lịch tiện lợi, nhanh chóng và đáng tin cậy
                    </p>
                    <div class="hero-actions">
                        <a class="hero-btn hero-btn-primary" href="booking.aspx">Đặt lịch ngay</a>
                        <a class="hero-btn hero-btn-secondary" href="services.aspx">Xem Dịch vụ</a>
                    </div>
                </div>
                <div class="services-anchor-title">Dịch vụ nổi bật</div>
            </div>
        </section>

        <section class="services">
            <div class="container">
                <div class="services-grid-top">
                    <article class="service-item service-item--top">
                        <div class="service-item__img-wrapper">
                            <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/Cham_soc_da.jpg") %>" alt="Chăm sóc da" />
                        </div>
                        <div class="service-item__content">
                            <h3 class="service-item__title">Chăm sóc da</h3>
                            <p class="service-item__desc">Nhận tư vấn liệu trình phù hợp, giúp da khỏe mạnh, sáng mịn và tươi trẻ mỗi ngày.</p>
                            <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                        </div>
                    </article>

                    <article class="service-item service-item--top">
                        <div class="service-item__img-wrapper">
                            <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/Dieu_tri_mun.jpg") %>" alt="Điều trị mụn" />
                        </div>
                        <div class="service-item__content">
                            <h3 class="service-item__title">Điều trị mụn</h3>
                            <p class="service-item__desc">Điều trị chuyên sâu, giảm viêm, hỗ trợ kiểm soát dầu và ngăn ngừa mụn quay lại.</p>
                            <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                        </div>
                    </article>

                    <article class="service-item service-item--top">
                        <div class="service-item__img-wrapper">
                            <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/Tam_trang.jpg") %>" alt="Tắm Trắng" />
                        </div>
                        <div class="service-item__content">
                            <h3 class="service-item__title">Tắm Trắng</h3>
                            <p class="service-item__desc">Dưỡng trắng an toàn, cải thiện độ đều màu và mịn màng, giúp làn da rạng rỡ tự tin.</p>
                            <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                        </div>
                    </article>
                </div>

                <div class="services-grid-bottom">
                    <article class="service-item service-item--bottom">
                        <div class="service-item__img-wrapper">
                            <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/phun_moi.jpg") %>" alt="Phun môi" />
                        </div>
                        <div class="service-item__content">
                            <h3 class="service-item__title">Phun môi</h3>
                            <p class="service-item__desc">Sở hữu đôi môi căng mọng, màu lên chuẩn đẹp tự nhiên giúp gương mặt thêm rạng rỡ.</p>
                            <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                        </div>
                    </article>

                    <article class="service-item service-item--bottom">
                        <div class="service-item__img-wrapper">
                            <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/xam_long_may.jpg") %>" alt="Điêu khắc lông mày" />
                        </div>
                        <div class="service-item__content">
                            <h3 class="service-item__title">Điêu khắc lông mày</h3>
                            <p class="service-item__desc">Chỉnh dáng theo khuôn mặt, lên màu tự nhiên, giúp lông mày sắc nét và hài hòa.</p>
                            <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                        </div>
                    </article>
                </div>
            </div>
        </section>

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
                                <a class="social-btn social-google" href="#" aria-label="Google">
                                    <i class="fa-brands fa-google"></i>
                                </a>
                                <p class="footer-connect__text">Nhóm 3.com</p>
                            </div>
                            <div class="footer-connect-item">
                                <a class="social-btn social-facebook" href="#" aria-label="Facebook">
                                    <i class="fa-brands fa-facebook-f"></i>
                                </a>
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