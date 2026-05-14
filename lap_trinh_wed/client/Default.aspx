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
                    <a href="promotions.aspx" class="nav-link">Mã khuyến mãi</a>
                    <a href="payment.aspx" class="nav-link">Thanh Toán</a>
                    <a href="profile.aspx" class="nav-link">Tài khoản</a>
                </nav>

                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon" aria-hidden="true"></i>
                    <span class="header-greeting">
                        <%= userGreeting %>
                    </span>
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
                    <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/phun_moi.jpg") %>" alt="Phun Môi" />
                </div>
                <div class="service-item__content">
                    <h3 class="service-item__title">Phun Môi Collagen</h3>
                    <p class="service-item__desc">Công nghệ phun môi giúp môi căng mọng, màu sắc tự nhiên và bền màu theo thời gian.</p>
                    <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                </div>
            </article>

            <article class="service-item service-item--bottom">
                <div class="service-item__img-wrapper">
                    <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/xam_long_may.jpg") %>" alt="Xăm Lông Mày" />
                </div>
                <div class="service-item__content">
                    <h3 class="service-item__title">Xăm Lông Mày 6D</h3>
                    <p class="service-item__desc">Điêu khắc chân mày tạo sợi tự nhiên, giúp khuôn mặt trở nên thanh tú và hài hòa hơn.</p>
                    <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                </div>
            </article>
        </div>
    </div>
</section>

                <div class="services-grid-bottom">
                    <asp:Repeater ID="rptBottomServices" runat="server">
                        <ItemTemplate>
                            <article class="service-item service-item--bottom">
                                <div class="service-item__img-wrapper">
                                    <img class="service-item__img" src="<%= ResolveUrl("~/assets/anh/phun_moi.jpg") %>" alt="<%# Eval("ten_dich_vu") %>" />
                                </div>
                                <div class="service-item__content">
                                    <h3 class="service-item__title"><%# Eval("ten_dich_vu") %></h3>
                                    <p class="service-item__desc"><%# Eval("mo_ta") %></p>
                                    <a class="service-item__cta" href="booking.aspx">ĐẶT LỊCH NGAY</a>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

  <section class="why-us" style="padding: 80px 0; background-color: #fff;">
    <div class="container">
        <div style="text-align: center; margin-bottom: 50px;">
            <h2 style="font-size: 32px; font-weight: 800; color: #db2777; text-transform: uppercase; letter-spacing: 1px; position: relative; display: inline-block; padding-bottom: 15px;">
                Tại sao nên chọn chúng tôi
                <span style="position: absolute; bottom: 0; left: 25%; width: 50%; height: 3px; background: #db2777; border-radius: 2px;"></span>
            </h2>
        </div>

        <div class="why-grid" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; align-items: stretch;">
            
            <div class="why-card" style="background: #fff; padding: 40px 25px; border-radius: 20px; text-align: center; display: flex; flex-direction: column; align-items: center; border: 1px solid #fce7f3; box-shadow: 0 10px 30px rgba(219, 39, 119, 0.05); height: 100%;">
                <div class="why-icon" style="width: 85px; height: 85px; background: #fdf2f8; color: #db2777; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 36px; margin-bottom: 25px; flex-shrink: 0;">
                    <i class="fa-solid fa-comments"></i>
                </div>
                <h4 class="why-title" style="font-size: 18px; font-weight: 700; color: #1f2937; margin-bottom: 15px; min-height: 44px; display: flex; align-items: center; justify-content: center; text-transform: uppercase;">Tư vấn tận tâm</h4>
                <p class="why-desc" style="font-size: 15px; color: #6b7280; line-height: 1.6; margin: 0;">Đội ngũ chuyên gia luôn lắng nghe và đưa ra liệu trình phù hợp nhất cho làn da của bạn.</p>
            </div>

            <div class="why-card" style="background: #fff; padding: 40px 25px; border-radius: 20px; text-align: center; display: flex; flex-direction: column; align-items: center; border: 1px solid #fce7f3; box-shadow: 0 10px 30px rgba(219, 39, 119, 0.05); height: 100%;">
                <div class="why-icon" style="width: 85px; height: 85px; background: #fdf2f8; color: #db2777; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 36px; margin-bottom: 25px; flex-shrink: 0;">
                    <i class="fa-solid fa-hand-holding-dollar"></i>
                </div>
                <h4 class="why-title" style="font-size: 18px; font-weight: 700; color: #1f2937; margin-bottom: 15px; min-height: 44px; display: flex; align-items: center; justify-content: center; text-transform: uppercase;">Giá cả minh bạch</h4>
                <p class="why-desc" style="font-size: 15px; color: #6b7280; line-height: 1.6; margin: 0;">Mọi chi phí đều được công khai rõ ràng, cam kết không phát sinh thêm bất kỳ phụ phí nào.</p>
            </div>

            <div class="why-card" style="background: #fff; padding: 40px 25px; border-radius: 20px; text-align: center; display: flex; flex-direction: column; align-items: center; border: 1px solid #fce7f3; box-shadow: 0 10px 30px rgba(219, 39, 119, 0.05); height: 100%;">
                <div class="why-icon" style="width: 85px; height: 85px; background: #fdf2f8; color: #db2777; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 36px; margin-bottom: 25px; flex-shrink: 0;">
                    <i class="fa-solid fa-shield-heart"></i>
                </div>
                <h4 class="why-title" style="font-size: 18px; font-weight: 700; color: #1f2937; margin-bottom: 15px; min-height: 44px; display: flex; align-items: center; justify-content: center; text-transform: uppercase;">Chất lượng đảm bảo</h4>
                <p class="why-desc" style="font-size: 15px; color: #6b7280; line-height: 1.6; margin: 0;">Sử dụng 100% sản phẩm cao cấp chính hãng và công nghệ làm đẹp tiên tiến nhất.</p>
            </div>

            <div class="why-card" style="background: #fff; padding: 40px 25px; border-radius: 20px; text-align: center; display: flex; flex-direction: column; align-items: center; border: 1px solid #fce7f3; box-shadow: 0 10px 30px rgba(219, 39, 119, 0.05); height: 100%;">
                <div class="why-icon" style="width: 85px; height: 85px; background: #fdf2f8; color: #db2777; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 36px; margin-bottom: 25px; flex-shrink: 0;">
                    <i class="fa-solid fa-certificate"></i>
                </div>
                <h4 class="why-title" style="font-size: 18px; font-weight: 700; color: #1f2937; margin-bottom: 15px; min-height: 44px; display: flex; align-items: center; justify-content: center; text-transform: uppercase;">Bảo hành dài hạn</h4>
                <p class="why-desc" style="font-size: 15px; color: #6b7280; line-height: 1.6; margin: 0;">Chính sách bảo hành uy tín, chăm sóc khách hàng chu đáo ngay cả sau khi sử dụng dịch vụ.</p>
            </div>
        </div>
    </div>
</section>
        <footer class="footer">
            <div class="container">
                <div class="footer-box">
                    <div class="footer-col">
                        <h3 class="footer-title">Thông tin liên hệ</h3>
                        <div class="footer-lines">
                            <p><i class="fa-solid fa-location-dot"></i> 96 - Định Công - Hoàng Mai - Hà Nội</p>
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