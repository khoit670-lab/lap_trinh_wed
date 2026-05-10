<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="services.aspx.cs" Inherits="lap_trinh_wed.client.services" %>

<!doctype html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa - Dịch vụ</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function checkEnter(e) {
            if (e.keyCode === 13) {
                // Ngăn chặn trình duyệt submit form mặc định
                e.preventDefault();
                // Kích hoạt sự kiện click của nút tìm kiếm
                document.getElementById('<%= btnSearch.ClientID %>').click();
                return false;
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
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
                    <a href="promotions.aspx" class="nav-link">Mã khuyến mãi</a>
                    <a href="login.aspx" class="nav-link">Tài khoản</a>
                </nav>
                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon"></i>
                    <span class="header-greeting"><%= userGreeting %></span>
                </div>
            </div>
        </header>

        <section class="hero">
            <div class="container">
                <div class="hero-banner">
                    <h1 class="hero-title">Chăm sóc sắc đẹp</h1>
                    <h2 class="hero-subtitle">Đặt lịch ngay hôm nay</h2>
                    <div class="hero-actions">
                        <a class="hero-btn hero-btn-primary" href="booking.aspx">Đặt lịch ngay</a>
                    </div>
                </div>
                <div class="services-anchor-title">Danh sách dịch vụ</div>
            </div>
        </section>

        <section class="services" id="services-list">
            <div class="container">
                <div class="bg-white border border-gray-200 rounded-3xl p-5 md:p-6">
                    
                    <div class="flex flex-wrap gap-3 items-center mb-6">
                        <div class="relative flex-1 max-w-md min-w-[220px]">
                            <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm kiếm dịch vụ..." 
                                CssClass="w-full pl-12 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500"
                                onkeydown="return checkEnter(event);"></asp:TextBox>
                            
                            <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" 
                                CssClass="absolute left-5 top-1/2 -translate-y-1/2 text-gray-400">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </asp:LinkButton>
                        </div>

                        <asp:Button ID="btnTatCa" runat="server" Text="Tất cả" OnClick="btnTatCa_Click" 
                            CssClass="px-6 py-3 bg-pink-600 text-white border border-pink-600 rounded-2xl text-sm font-medium cursor-pointer transition" />

                        <asp:Repeater ID="rptDanhMuc" runat="server">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnLoc" runat="server" 
                                    CssClass='<%# Convert.ToInt32(Eval("id")) == selectedDanhMucId ? "px-6 py-3 bg-pink-600 text-white border border-pink-600 rounded-2xl text-sm font-medium transition" : "px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700 transition" %>'
                                    CommandArgument='<%# Eval("id") %>' OnClick="btnLoc_Click">
                                    <%# Eval("ten_danh_muc") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <asp:Label ID="lblKhongCoKetQua" runat="server" Text="Không tìm thấy dịch vụ nào phù hợp." 
                            Visible="false" CssClass="col-span-full text-center py-10 text-gray-500 italic"></asp:Label>

                        <asp:Repeater ID="rptDichVu" runat="server">
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
                                        
                                        <p class="text-sm text-gray-600 mb-4 line-clamp-2">
                                            <%# Eval("mo_ta") %>
                                        </p>
                                        
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
                            <p><i class="fa-regular fa-clock"></i> 8h30 - 22h00</p>
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