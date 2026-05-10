<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="booking.aspx.cs" Inherits="lap_trinh_wed.client.booking" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa - Đặt Lịch</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        .booking-form-container {
            background: #ffffff;
            border: 2px solid #3b82f6; 
            border-radius: 20px;
            padding: 40px;
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #f04581;
        }
        .input-control {
            width: 100%;
            border: 1px solid #d1d5db;
            border-radius: 12px;
            padding: 12px 15px 12px 45px;
            outline: none;
            transition: all 0.3s;
        }
        .input-control:focus {
            border-color: #f04581;
            box-shadow: 0 0 0 2px rgba(240, 69, 129, 0.1);
        }
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
                    <a href="booking.aspx" class="nav-link active">Đặt lịch</a>
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
                    <h1 class="hero-title">ĐẶT LỊCH HẸN</h1>
                    <h2 class="hero-subtitle">Điền thông tin để đặt lịch dịch vụ</h2>
                    <p class="hero-desc">Lựa chọn thời gian và dịch vụ phù hợp với bạn để tận hưởng giây phút thư giãn tuyệt vời nhất.</p>
                    <div class="hero-actions">
                        <a class="hero-btn hero-btn-primary" href="#form-section">Bắt đầu điền form</a>
                    </div>
                </div>
                <div class="services-anchor-title">Phiếu đăng ký dịch vụ</div>
            </div>
        </section>

        <main id="form-section" class="container mx-auto px-4 pb-20">
            <div class="max-w-4xl mx-auto booking-form-container shadow-2xl">
                <div class="space-y-8">
                    <div>
                        <h3 class="text-gray-700 font-bold mb-4 uppercase text-sm tracking-widest">Thông tin cá nhân:</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-1">
                                <label class="text-xs font-bold text-gray-500 ml-1">Họ và tên :</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-user"></i>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="input-control" placeholder="Nguyễn Văn A"></asp:TextBox>
                                </div>
                            </div>
                            <div class="space-y-1">
                                <label class="text-xs font-bold text-gray-500 ml-1">Số điện thoại :</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-phone"></i>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="input-control" placeholder="090x xxx xxx"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-1">
                        <h3 class="text-gray-700 font-bold mb-2 uppercase text-sm tracking-widest">Chọn dịch vụ :</h3>
                        <div class="input-group">
                            <i class="fa-solid fa-magic-wand-sparkles"></i>
                            <asp:DropDownList ID="ddlService" runat="server" CssClass="input-control appearance-none"></asp:DropDownList>
                            <i class="fa-solid fa-chevron-down absolute right-5 left-auto text-gray-400"></i>
                        </div>
                    </div>

                    <div>
                        <h3 class="text-gray-700 font-bold mb-4 uppercase text-sm tracking-widest">Thời gian :</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="input-group">
                                <i class="fa-solid fa-calendar-check"></i>
                                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="input-control"></asp:TextBox>
                            </div>
                            <div class="input-group">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                                <asp:TextBox ID="txtTime" runat="server" TextMode="Time" CssClass="input-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-1">
                        <label class="text-xs font-bold text-gray-500 ml-1">Mã giảm giá (nếu có) :</label>
                        <div class="input-group">
                            <i class="fa-solid fa-ticket"></i>
                            <asp:TextBox ID="txtVoucherCode" runat="server" CssClass="input-control" placeholder="Nhập mã ưu đãi của bạn"></asp:TextBox>
                        </div>
                    </div>

                    <div class="space-y-1">
                        <label class="text-xs font-bold text-gray-500">Ghi chú :</label>
                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Rows="3" 
                            CssClass="w-full border border-gray-300 rounded-xl px-5 py-3 outline-none focus:border-pink-500 transition-all" 
                            placeholder="Bạn có yêu cầu đặc biệt nào không?"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnSubmit" runat="server" Text="ĐẶT LỊCH NGAY" OnClick="btnSubmit_Click"
                        CssClass="w-full bg-[#f04581] hover:bg-pink-700 text-white font-black py-4 rounded-xl shadow-xl transition-all text-xl cursor-pointer uppercase tracking-tighter" />
                </div>
            </div>
        </main>

        </form>
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
</body>
</html>