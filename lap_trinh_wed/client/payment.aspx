<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="lap_trinh_wed.client.payment" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lily Spa - Thanh Toán</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    
    <!-- ✅ SWEETALERT2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        /* ... giữ nguyên tất cả CSS cũ của bạn ... */
        .payment-container {
            background: #ffffff;
            border: 2px solid #3b82f6; 
            border-radius: 20px;
            padding: 40px;
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }
        .input-group { position: relative; margin-bottom: 20px; }
        .input-group i { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #f04581; }
        .input-control { width: 100%; border: 1px solid #d1d5db; border-radius: 12px; padding: 12px 15px 12px 45px; outline: none; transition: all 0.3s; }
        .input-control:focus { border-color: #f04581; box-shadow: 0 0 0 2px rgba(240, 69, 129, 0.1); }
        .payment-summary { background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); border: 2px solid #e2e8f0; border-radius: 16px; padding: 24px; }
        .payment-method-card { border: 2px solid #e5e7eb; border-radius: 12px; padding: 20px; transition: all 0.3s; cursor: pointer; }
        .payment-method-card:hover, .payment-method-card.active { border-color: #f04581; background: rgba(240, 69, 129, 0.05); }
        .progress-step { display: inline-flex; align-items: center; gap: 8px; font-weight: 600; color: #6b7280; }
        .progress-step.active { color: #f04581; }
        .progress-step.completed::before { content: "✓"; color: #10b981; font-weight: bold; margin-right: 8px; }
        .btn-disabled { opacity: 0.6; cursor: not-allowed !important; }
    </style>
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        <!-- HEADER GIỮ NGUYÊN -->
        <header class="site-header">
            <div class="container header-inner">
                <a class="logo" href="Default.aspx"><span class="logo-text">Lily Spa</span></a>
                <nav class="site-nav">
                    <a href="Default.aspx" class="nav-link">Trang chủ</a>
                    <a href="services.aspx" class="nav-link">Dịch vụ làm đẹp</a>
                    <a href="booking.aspx" class="nav-link">Đặt lịch</a>
                    <a href="promotions.aspx" class="nav-link">Mã khuyến mãi</a>
                    <a href="profile.aspx" class="nav-link">Tài khoản</a>
                </nav>
                <div class="header-right">
                    <i class="fa-regular fa-user header-user-icon"></i>
                    <span class="header-greeting"><%= userGreeting %></span>
                </div>
            </div>
        </header>

        <!-- HERO GIỮ NGUYÊN -->
        <section class="hero">
            <div class="container">
                <div class="hero-banner">
                    <h1 class="hero-title">THANH TOÁN</h1>
                    <h2 class="hero-subtitle">Xác nhận thanh toán để hoàn tất lịch hẹn</h2>
                    <div class="flex items-center justify-center gap-6 mt-6 p-4 bg-white/30 rounded-2xl backdrop-blur-sm">
                        <div class="flex items-center gap-2 bg-green-100 text-green-800 px-6 py-3 rounded-xl font-semibold shadow-lg">
                            <i class="fa-solid fa-check-circle text-xl"></i><span>1. Đã đặt lịch</span>
                        </div>
                        <div class="w-20 h-1 bg-green-300 rounded-full"></div>
                        <div class="flex items-center gap-2 bg-pink-100 text-pink-800 px-6 py-3 rounded-xl font-semibold shadow-lg">
                            <i class="fa-solid fa-credit-card text-xl"></i><span>2. Thanh toán</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- MAIN CONTENT GIỮ NGUYÊN -->
        <main class="container mx-auto px-4 pb-20">
            <div class="max-w-4xl mx-auto">
                <div class="payment-container mb-8 p-6 bg-gradient-to-r from-blue-50 to-indigo-50">
                    <div class="flex items-center justify-between mb-4">
                        <div class="progress-step completed"><i class="fa-solid fa-check-circle text-green-500"></i>1. Đặt lịch</div>
                        <div class="w-16 h-1 bg-green-300 rounded-full"></div>
                        <div class="progress-step active"><i class="fa-solid fa-credit-card text-pink-500"></i>2. Thanh toán</div>
                        <div class="w-16 h-1 bg-gray-200 rounded-full"></div>
                        <div class="progress-step"><i class="fa-solid fa-check-double"></i>3. Hoàn tất</div>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- LEFT: Payment Summary -->
                    <div class="payment-container shadow-2xl">
                        <h3 class="text-2xl font-black text-gray-800 mb-8 uppercase tracking-wider">
                            <i class="fa-solid fa-receipt text-pink-500 mr-3"></i>TÓM TẮT ĐƠN HÀNG
                        </h3>
                        <div class="payment-summary mb-6">
                            <h4 class="font-bold text-lg mb-4 text-gray-700 flex items-center">
                                <i class="fa-solid fa-user text-pink-500 mr-2"></i>Thông tin khách hàng
                            </h4>
                            <asp:Label ID="lblCustomerInfo" runat="server" CssClass="text-gray-600 space-y-1 block"></asp:Label>
                        </div>
                        <div class="payment-summary mb-6">
                            <h4 class="font-bold text-lg mb-4 text-gray-700 flex items-center">
                                <i class="fa-solid fa-spa text-pink-500 mr-2"></i>Dịch vụ & Thời gian
                            </h4>
                            <div class="space-y-2">
                                <asp:Label ID="lblServiceInfo" runat="server" CssClass="font-semibold text-gray-800"></asp:Label>
                                <asp:Label ID="lblDateTimeInfo" runat="server" CssClass="text-sm text-gray-500"></asp:Label>
                            </div>
                        </div>
                        <div class="payment-summary">
                            <div class="space-y-3">
                                <div class="flex justify-between text-lg">
                                    <span>Giá dịch vụ:</span>
                                    <asp:Label ID="lblServicePrice" runat="server" CssClass="font-bold text-pink-500">0₫</asp:Label>
                                </div>
                                <div class="flex justify-between text-sm text-gray-500 line-through" id="lblOriginalPrice" runat="server" visible="false">
                                    <span>Giá gốc:</span><span>0₫</span>
                                </div>
                                <div class="flex justify-between text-sm text-green-600" id="lblDiscount" runat="server" visible="false">
                                    <span>Giảm giá:</span><span>-0₫</span>
                                </div>
                                <hr class="border-gray-200">
                                <div class="flex justify-between text-2xl font-black text-pink-500">
                                    <span>Tổng tiền:</span>
                                    <asp:Label ID="lblTotalAmount" runat="server" CssClass="text-3xl">0₫</asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT: Payment Form -->
                    <div class="payment-container shadow-2xl">
                        <h3 class="text-2xl font-black text-gray-800 mb-8 uppercase tracking-wider">
                            <i class="fa-solid fa-credit-card text-pink-500 mr-3"></i>PHƯƠNG THỨC THANH TOÁN
                        </h3>

                        <div class="space-y-4 mb-8">
                            <asp:RadioButtonList ID="rblPaymentMethod" runat="server" CssClass="space-y-3" 
                                OnSelectedIndexChanged="rblPaymentMethod_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="cod">
                                    <div class="payment-method-card flex items-center p-4 rounded-xl">
                                        <i class="fa-solid fa-truck text-2xl text-orange-500 mr-4"></i>
                                        <div><div class="font-bold text-lg">Thanh toán khi nhận hàng</div>
                                        <div class="text-sm text-gray-500">Thanh toán trực tiếp cho nhân viên</div></div>
                                    </div>
                                </asp:ListItem>
                                <asp:ListItem Value="vnpay">
                                    <div class="payment-method-card flex items-center p-4 rounded-xl">
                                        <img src="https://logoeps.com/wp-content/uploads/2013/03/vnpay-vector-logo.png" alt="VNPay" class="w-12 h-12 mr-4 rounded-lg" />
                                        <div><div class="font-bold text-lg">VNPay QR</div><div class="text-sm text-gray-500">Thanh toán qua mã QR VNPay</div></div>
                                    </div>
                                </asp:ListItem>
                                <asp:ListItem Value="momo">
                                    <div class="payment-method-card flex items-center p-4 rounded-xl">
                                        <img src="https://upload.wikimedia.org/wikipedia/vi/thumb/4/44/MoMo_Logo_2020.svg/2560px-MoMo_Logo_2020.svg.png" alt="Momo" class="w-12 h-12 mr-4 rounded-lg" />
                                        <div><div class="font-bold text-lg">Momo</div><div class="text-sm text-gray-500">Thanh toán qua ví Momo</div></div>
                                    </div>
                                </asp:ListItem>
                                <asp:ListItem Value="bank">
                                    <div class="payment-method-card flex items-center p-4 rounded-xl">
                                        <i class="fa-solid fa-building-columns text-2xl text-blue-500 mr-4"></i>
                                        <div><div class="font-bold text-lg">Chuyển khoản ngân hàng</div><div class="text-sm text-gray-500">TK: 123456789 - VPBank</div></div>
                                    </div>
                                </asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div id="paymentInstructions" runat="server" class="bg-blue-50 border border-blue-200 rounded-xl p-6 mb-6" visible="false">
                            <h4 class="font-bold text-lg mb-3 flex items-center text-blue-800">
                                <i class="fa-solid fa-info-circle mr-2"></i>Hướng dẫn thanh toán
                            </h4>
                            <asp:Literal ID="litPaymentInstructions" runat="server"></asp:Literal>
                        </div>

                        <div class="border-t border-gray-200 pt-6">
                            <label class="flex items-center mb-4">
                                <asp:CheckBox ID="chkTerms" runat="server" CssClass="w-4 h-4 text-pink-500 border-gray-300 rounded focus:ring-pink-500" />
                                <span class="ml-2 text-sm text-gray-600">
                                    Tôi đồng ý với <a href="#" class="text-pink-500 hover:underline font-semibold">điều khoản dịch vụ</a> 
                                    và <a href="#" class="text-pink-500 hover:underline font-semibold">chính sách bảo mật</a>
                                </span>
                            </label>
                            <asp:Button ID="btnConfirmPayment" runat="server" Text="XÁC NHẬN THANH TOÁN" 
                                OnClick="btnConfirmPayment_Click"
                                CssClass="w-full bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white font-black py-4 rounded-xl shadow-xl transition-all text-xl cursor-pointer uppercase tracking-wider transform hover:scale-[1.02] active:scale-[0.98]" />
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- FOOTER GIỮ NGUYÊN -->
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

    <!-- ✅ JAVASCRIPT CẢI TIẾN -->
    <script>
        // Highlight payment method
        document.querySelectorAll('.payment-method-card').forEach((card, index) => {
            card.addEventListener('click', function() {
                document.querySelectorAll('.payment-method-card').forEach(c => c.classList.remove('active'));
                this.classList.add('active');
                // Trigger RadioButtonList
                this.closest('.payment-method-card').previousElementSibling.click();
            });
        });

        // Disable button khi đang loading
        function setLoading(state) {
            const btn = document.getElementById('<%= btnConfirmPayment.ClientID %>');
            if (state) {
                btn.disabled = true;
                btn.classList.add('btn-disabled');
                btn.innerHTML = '<i class="fa fa-spinner fa-spin mr-2"></i>ĐANG XỬ LÝ...';
            } else {
                btn.disabled = false;
                btn.classList.remove('btn-disabled');
                btn.innerHTML = 'XÁC NHẬN THANH TOÁN';
            }
        }
    </script>
</body>
</html>