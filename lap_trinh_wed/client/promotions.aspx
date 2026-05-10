<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="promotions.aspx.cs" Inherits="lap_trinh_wed.client.promotions" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa - Mã Khuyến Mãi</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        .promotion-container {
            background: #ffffff;
            border: 2px solid #f04581; 
            border-radius: 20px;
            padding: 40px;
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }
        .filter-btn {
            border: 1px solid #d1d5db;
            border-radius: 12px;
            padding: 8px 24px;
            font-size: 15px;
            color: #4b5563;
            background: white;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .filter-btn.active { 
            background: #d81b60; 
            color: white; 
            border-color: #d81b60; 
        }
        .filter-btn:hover:not(.active) { 
            border-color: #d81b60; 
            color: #d81b60; 
        }
        .service-style-card {
            background: white;
            border: 1px solid #f3f4f6;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.03);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .service-style-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
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
                    <a href="promotions.aspx" class="nav-link active">Mã khuyến mãi</a>
                    <a href="login.aspx" class="nav-link">Tài khoản</a>
                </nav>
                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon"></i>
                    <span class="header-greeting">
                        <asp:Literal ID="litUserGreeting" runat="server"></asp:Literal>
                    </span>
                </div>
            </div>
        </header>

        <section class="hero">
            <div class="container">
                <div class="hero-banner">
                    <h1 class="hero-title"><%= bannerTenVoucher %></h1>
                    <h2 class="hero-subtitle">Mã Khuyến Mãi & Ưu Đãi</h2>
                    <p class="hero-desc">
                        <%= bannerMoTa %>
                    </p>
                    <div class="hero-actions">
                        <a class="hero-btn hero-btn-primary" href="#voucher-section">Săn Mã Ngay</a>
                    </div>
                </div>
                <div class="services-anchor-title">Danh sách Mã Giảm Giá</div>
            </div>
        </section>

        <main id="voucher-section" class="container mx-auto px-4 pb-20">
            <div class="max-w-6xl mx-auto promotion-container shadow-2xl">
                <div class="flex flex-wrap gap-4 mb-10 justify-center">
                    <asp:Button ID="btnTatCa" runat="server" CssClass="filter-btn active" Text="Tất cả" OnClick="btnTatCa_Click" />
                    <asp:Button ID="btnDangApDung" runat="server" CssClass="filter-btn" Text="Đang áp dụng" OnClick="btnDangApDung_Click" />
                    <asp:Button ID="btnThanhVien" runat="server" CssClass="filter-btn" Text="Thành viên" OnClick="btnThanhVien_Click" />
                    <asp:Button ID="btnSapHetHan" runat="server" CssClass="filter-btn" Text="Sắp hết hạn" OnClick="btnSapHetHan_Click" />
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <asp:Repeater ID="rptVoucher" runat="server" OnItemCommand="rptVoucher_ItemCommand">
                        <ItemTemplate>
                            <div class="service-style-card">
                                <div class="h-48 w-full bg-[#fff5f5] border-b-2 border-dashed border-gray-200 flex flex-col justify-center items-center">
                                    <img src="https://img.icons8.com/color/96/gift-card.png" class="mx-auto h-20" alt="Voucher Icon" />
                                    <span class="block mt-2 font-bold text-orange-500">VOUCHER</span>
                                </div>
                                <div class="p-6 text-center flex-grow flex flex-col justify-center">
                                    <h3 class="font-bold text-[#d81b60] text-[17px] mb-2"><%# Eval("ten_voucher") %></h3>
                                    <p class="text-sm text-gray-500 mb-1">
                                        Giảm: <strong><%# FormatGiamGia(Eval("loai_giam"), Eval("gia_tri_giam")) %></strong> • <%# FormatDieuKien(Eval("dieu_kien_ap_dung"), Eval("mo_ta")) %>
                                    </p>
                                    <p class="text-xs text-gray-400">
                                        <%# FormatNgayHH(Eval("ngay_het_han")) %>
                                    </p>
                                </div>
                                <div class="px-6 pb-6 mt-auto">
                                    <asp:Button ID="btnNhanUuDai" runat="server" 
                                        CommandName="NhanUuDai" 
                                        CommandArgument='<%# Eval("ma_voucher") %>'
                                        Text="NHẬN ƯU ĐÃI" 
                                        CssClass="w-full bg-[#d81b60] hover:bg-[#b0124b] text-white font-bold py-3 rounded-lg uppercase tracking-wide transition-colors text-sm" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </main>

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