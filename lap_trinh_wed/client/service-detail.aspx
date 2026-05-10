<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="service-detail.aspx.cs" Inherits="lap_trinh_wed.client.service_detail" %>

<!doctype html>
<html lang="vi">
  <head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%= tenDichVu %> - Lily Spa</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
      rel="stylesheet"
    />
  </head>
  <body class="bg-gray-50">
    <form id="form1" runat="server">
    <header class="site-header">
      <div class="container header-inner">
        <a class="logo" href="index.aspx">
          <span class="logo-text">Lily Spa</span>
        </a>

        <nav class="site-nav" aria-label="Điều hướng">
          <a href="index.aspx" class="nav-link">Trang chủ</a>
          <a href="services.aspx" class="nav-link">Dịch vụ làm đẹp</a>
          <a href="booking.aspx" class="nav-link">Đặt lịch</a>
          <a href="promotions.aspx" class="nav-link">Mã khuyến mãi</a>
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

      <div class="bg-white rounded-3xl shadow-lg overflow-hidden">
        <div class="grid md:grid-cols-2 gap-0">
          <div class="p-6 bg-white flex items-center justify-center service-item__img-wrapper">
            <img
              src="<%= hinhAnhUrl %>"
              class="w-full rounded-2xl shadow-lg object-cover service-item__img"
              style="height: auto; min-height: 400px;"
              alt="<%= tenDichVu %>"
            />
          </div>

          <div class="p-8 flex flex-col justify-between bg-white">
            <div>
              <h1 class="text-2xl font-bold text-pink-600 mb-2">
                <%= tenDichVu %>
              </h1>
              <p class="text-xl font-bold text-pink-600 mb-6">
                <%= giaHienThi %> • <%= thoiGianHienThi %>
              </p>

              <div class="space-y-3">
                <div>
                  <p class="font-semibold text-sm text-gray-700">Công dụng:</p>
                  <p class="text-sm text-gray-600"><%= moTa %></p>
                </div>
                <div>
                  <p class="font-semibold text-sm text-gray-700">Liệu trình / Kỹ thuật:</p>
                  <p class="text-sm text-gray-600"><%= lamGi %></p>
                </div>
              </div>
            </div>

            <asp:Button 
                ID="btnDatLich" 
                runat="server" 
                Text="ĐẶT LỊCH NGAY" 
                OnClick="btnDatLich_Click" 
                CssClass="mt-6 w-full bg-pink-600 hover:bg-pink-700 text-white font-bold py-3 rounded-2xl text-base transition cursor-pointer" 
            />
          </div>
        </div>
      </div>

      <div class="mt-16">
        <h2 class="text-2xl font-bold mb-8">Dịch vụ liên quan</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <asp:Repeater ID="rptLienQuan" runat="server">
            <ItemTemplate>
              <article class="bg-white rounded-3xl shadow-lg overflow-hidden hover:shadow-xl transition transform hover:-translate-y-2 duration-300 flex flex-col h-full">
                  
                  <a href='<%# DetailUrl(Eval("id")) %>' class="relative h-56 overflow-hidden bg-gray-200 block">
                      <img src='<%# AnhUrl(Eval("hinh_anh")) %>' 
                          class="w-full h-full object-cover hover:scale-105 transition-transform duration-300" alt='<%# Eval("ten_dich_vu") %>' />
                  </a>
                  
                  <div class="p-6 text-center flex flex-col flex-grow">
                      <a href='<%# DetailUrl(Eval("id")) %>' class="block mb-2">
                          <h3 class="text-lg font-bold text-pink-600 hover:text-pink-800 transition"><%# Eval("ten_dich_vu") %></h3>
                      </a>
                      
                      <div class="text-sm text-gray-500 mb-6 mt-auto">
                          <%# FormatGia(Eval("gia_goc"), Eval("gia_khuyen_mai")) %> • <%# Eval("thoi_gian") %> phút
                      </div>
                      
                      <a href='<%# BookingUrl(Eval("id")) %>' class="block w-full bg-pink-600 hover:bg-pink-700 text-white font-bold py-3 rounded-2xl text-sm transition cursor-pointer">
                          ĐẶT LỊCH NGAY
                      </a>
                  </div>
                  
              </article>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </div>

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