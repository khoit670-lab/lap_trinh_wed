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
            font-size: 14px;
        }
        .input-control:focus {
            border-color: #f04581;
            box-shadow: 0 0 0 2px rgba(240, 69, 129, 0.1);
        }
        /* ✅ CSS CHO SERVICE CARD */
        .selected-service-card {
            animation: slideInUp 0.5s ease-out;
        }
        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
                    <a href="payment.aspx" class="nav-link">Thanh toán</a>
                    <a href="profile.aspx" class="nav-link">Tài khoản</a>
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
                    
                    <!-- ✅ PHẦN HIỂN THỊ DỊCH VỤ ĐÃ CHỌN -->
                    <asp:Label ID="lblSelectedService" runat="server" Visible="false"></asp:Label>

                    <!-- ✅ THÔNG TIN CÁ NHÂN -->
                    <div>
                        <h3 class="text-gray-700 font-bold mb-6 uppercase text-sm tracking-widest border-b border-pink-200 pb-2">
                            <i class="fa-solid fa-user text-pink-500 mr-2"></i>Thông tin cá nhân
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-xs font-bold text-gray-500 ml-1 block mb-1">Họ và tên <span class="text-red-500">*</span>:</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-user"></i>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="input-control" placeholder="Nguyễn Văn A" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-bold text-gray-500 ml-1 block mb-1">Số điện thoại <span class="text-red-500">*</span>:</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-phone"></i>
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="input-control" placeholder="090xxxxxxx" MaxLength="11"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ✅ CHỌN DỊCH VỤ - CÓ EVENT -->
                    <div class="space-y-3">
                        <h3 class="text-gray-700 font-bold mb-4 uppercase text-sm tracking-widest border-b border-pink-200 pb-2">
                            <i class="fa-solid fa-spa text-pink-500 mr-2"></i>Chọn dịch vụ <span class="text-red-500">*</span>
                        </h3>
                        <div class="input-group">
                            <i class="fa-solid fa-magic-wand-sparkles"></i>
                            <asp:DropDownList ID="ddlService" runat="server" 
                                              CssClass="input-control appearance-none" 
                                              AutoPostBack="true" 
                                              OnSelectedIndexChanged="DdlService_SelectedIndexChanged">
                            </asp:DropDownList>
                            <i class="fa-solid fa-chevron-down absolute right-5 left-auto text-gray-400 top-1/2 -translate-y-1/2"></i>
                        </div>
                    </div>

                    <!-- ✅ THỜI GIAN -->
                    <div>
                        <h3 class="text-gray-700 font-bold mb-6 uppercase text-sm tracking-widest border-b border-pink-200 pb-2">
                            <i class="fa-solid fa-calendar text-pink-500 mr-2"></i>Thời gian <span class="text-red-500">*</span>
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-xs font-bold text-gray-500 ml-1 block mb-1">Ngày hẹn:</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-calendar-check"></i>
                                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="input-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-bold text-gray-500 ml-1 block mb-1">Giờ hẹn:</label>
                                <div class="input-group">
                                    <i class="fa-solid fa-clock"></i>
                                    <asp:TextBox ID="txtTime" runat="server" TextMode="Time" CssClass="input-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ✅ VOUCHER -->
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-500 ml-1 block mb-2">Mã giảm giá:</label>
                        <div class="input-group">
                            <i class="fa-solid fa-ticket"></i>
                            <asp:TextBox ID="txtVoucherCode" runat="server" CssClass="input-control" 
                                         placeholder="Nhập mã ưu đãi (VD: GIAM40)" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>

                    <!-- ✅ GHI CHÚ -->
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-500 block mb-2">Ghi chú:</label>
                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Rows="3" 
                                     CssClass="w-full border border-gray-300 rounded-xl px-5 py-3 outline-none focus:border-pink-500 focus:ring-2 focus:ring-pink-200 transition-all resize-vertical" 
                                     placeholder="Yêu cầu đặc biệt? Dị ứng? Nhân viên yêu thích?..."></asp:TextBox>
                    </div>

                    <!-- ✅ NÚT SUBMIT ĐẸP HƠN -->
                    <asp:Button ID="btnSubmit" runat="server" Text="🚀 ĐẶT LỊCH NGAY & THANH TOÁN" OnClick="btnSubmit_Click"
                        CssClass="w-full bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white font-black py-5 rounded-2xl shadow-2xl hover:shadow-3xl transition-all text-xl cursor-pointer uppercase tracking-wider transform hover:scale-[1.02] active:scale-[0.98] border-0" />

                    <!-- ✅ THÔNG BÁO YÊU CẦU -->
                    <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 text-sm text-blue-800">
                        <i class="fa-solid fa-info-circle mr-2"></i>
                        <strong>Lưu ý:</strong> Sau khi đặt lịch bạn sẽ được chuyển đến trang thanh toán để chọn phương thức phù hợp.
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

    <!-- ✅ JAVASCRIPT TƯƠNG TÁC -->
    <script>
        // Format số điện thoại real-time
        document.getElementById('<%= txtPhone.ClientID %>').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '').slice(0, 10);
            if (value.length >= 4) {
                value = value.replace(/(\d{4})(\d{3})(\d{3})/, '$1 $2 $3');
            }
            e.target.value = value;
        });

        // Chọn giờ đẹp (9h-20h)
        document.getElementById('<%= txtTime.ClientID %>').addEventListener('change', function(e) {
            let time = e.target.value;
            let hour = parseInt(time.split(':')[0]);
            if (hour < 9 || hour > 20) {
                alert('Giờ làm việc: 9h-20h');
                e.target.value = '';
            }
        });
    </script>
</body>
</html>