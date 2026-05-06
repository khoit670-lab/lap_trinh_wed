<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="service-detail.aspx.cs" Inherits="lap_trinh_wed.client.service_detail" %>

<!doctype html>
<html lang="vi">
  <head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chi tiết dịch vụ - Lily Spa</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
      rel="stylesheet"
    />
  </head>
  <body>
    <form id="form1" runat="server">
    <!-- Header: Đồng bộ với index.html -->
    <header class="site-header">
      <div class="container header-inner">
        <a class="logo" href="index.aspx">
          <span class="logo-text">Lily Spa</span>
        </a>

        <nav class="site-nav" aria-label="Điều hướng">
          <a href="index.aspx" class="nav-link">Trang chủ</a>
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

    <div class="container py-8">
      <a href="services.aspx" class="inline-block mb-6 text-pink-600 font-semibold hover:underline">← Quay lại danh sách dịch vụ</a>

      <!-- Service Detail Card: Giữ nguyên 100% cấu trúc của bạn -->
      <div class="bg-white rounded-3xl shadow-lg overflow-hidden">
        <div class="grid md:grid-cols-2 gap-0">
          <!-- Image -->
          <div class="p-6 bg-white flex items-center justify-center service-item__img-wrapper">
            <img
              src="<%= ResolveUrl("~/assets/anh/cham_soc_da_mat_Collagen_Glow.jpg") %>"
              class="w-full rounded-2xl shadow-lg object-cover service-item__img"
              style="height: auto; min-height: 400px;"
              alt="Dịch vụ"
            />
          </div>

          <!-- Info -->
          <div class="p-8 flex flex-col justify-between bg-white">
            <div>
              <h1 class="text-2xl font-bold text-pink-600 mb-2">
                Chăm Sóc Da Mặt Collagen Glow
              </h1>
              <p class="text-xl font-bold text-pink-600 mb-6">
                1.200.000 đ • 60 phút
              </p>

              <div class="space-y-3">
                <div>
                  <p class="font-semibold text-sm text-gray-700">Công dụng:</p>
                  <p class="text-sm text-gray-600">
                    Phục hồi da, căng bóng, giảm thâm nám
                  </p>
                </div>
                <div>
                  <p class="font-semibold text-sm text-gray-700">Công dụng:</p>
                  <p class="text-sm text-gray-600">Làm sạch da, Massage</p>
                </div>
                <div>
                  <p class="font-semibold text-sm text-gray-700">Liệu trình:</p>
                  <p class="text-sm text-gray-600">
                    Massage + Đắp mặt nạ Collagen + Laser
                  </p>
                </div>
                <div>
                  <p class="font-semibold text-sm text-gray-700">Kỹ thuật:</p>
                  <p class="text-sm text-gray-600">
                    Skincare + Mặt nạ Collagen + Laser
                  </p>
                </div>
              </div>
            </div>

            <button
              type="button"
              onclick="alert('Đã thêm vào lịch hẹn!')"
              class="mt-6 w-full bg-pink-600 hover:bg-pink-700 text-white font-bold py-3 rounded-2xl text-base transition"
            >
              ĐẶT LỊCH NGAY
            </button>
          </div>
        </div>
      </div>

      <!-- Related Services: Giữ nguyên các article của bạn -->
      <div class="mt-16">
        <h2 class="text-2xl font-bold mb-8">Dịch vụ liên quan</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <article class="service-item">
            <div class="service-item__img-wrapper">
              <img
                src="<%= ResolveUrl("~/assets/anh/Facial_Duong_Trang_Vitamin_C.jpg") %>"
                class="service-item__img"
                alt="Trị Mụn Chuyên Sâu"
              />
            </div>
            <div class="service-item__content">
              <h3 class="service-item__title">Trị Mụn Chuyên Sâu</h3>
              <p class="service-item__desc">950.000 đ • 45 phút</p>
              <a href="service-detail.aspx" class="service-item__cta">ĐẶT LỊCH NGAY</a>
            </div>
          </article>

          <article class="service-item">
            <div class="service-item__img-wrapper">
              <img
                src="<%= ResolveUrl("~/assets/anh/Massage_thu_gian_toan_than.jpg") %>"
                class="service-item__img"
                alt="Massage Thư Giãn"
              />
            </div>
            <div class="service-item__content">
              <h3 class="service-item__title">Massage Thư Giãn</h3>
              <p class="service-item__desc">800.000 đ • 90 phút</p>
              <a href="service-detail.aspx" class="service-item__cta">ĐẶT LỊCH NGAY</a>
            </div>
          </article>

          <article class="service-item">
            <div class="service-item__img-wrapper">
              <img
                src="<%= ResolveUrl("~/assets/anh/Body_Detox_Tan_Mo.jpg") %>"
                class="service-item__img"
                alt="Body Detox & Tân Mỡ"
              />
            </div>
            <div class="service-item__content">
              <h3 class="service-item__title">Body Detox & Tân Mỡ</h3>
              <p class="service-item__desc">1.000.000 đ • 60 phút</p>
              <a href="service-detail.aspx" class="service-item__cta">ĐẶT LỊCH NGAY</a>
            </div>
          </article>
        </div>
      </div>
    </div>

    <!-- Footer: Giữ nguyên địa chỉ Phương Bình Công -->
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