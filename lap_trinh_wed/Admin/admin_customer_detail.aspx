<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_customer_detail.aspx.cs" Inherits="lap_trinh_wed.admin.admin_customer_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Chi tiết khách hàng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f0f2f5; padding: 40px; display: flex; justify-content: center; }

        /* Container chính */
        .detail-container {
            background: #fff; width: 600px; border-radius: 30px;
            padding: 35px; box-shadow: 0 15px 40px rgba(0,0,0,0.1);
            position: relative;
        }

        .title-screen { font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 30px; }

        /* Header: Avatar + Thông tin cơ bản */
        .profile-header { display: flex; gap: 25px; align-items: center; margin-bottom: 35px; }
        .avatar-box {
            width: 130px; height: 130px; background: #fff0f3; 
            border-radius: 20px; overflow: hidden; border: 1px solid #eee;
        }
        .avatar-box img { width: 100%; height: 100%; object-fit: cover; }
        
        .basic-info h2 { font-size: 16px; color: #888; font-weight: normal; margin-bottom: 5px; }
        .customer-name { font-size: 24px; font-weight: bold; margin-bottom: 5px; }
        .customer-phone { font-size: 18px; margin-bottom: 15px; display: block; }
        
        .stats-row { display: flex; gap: 40px; }
        .stat-item .label { font-size: 22px; font-weight: bold; display: block; }
        .stat-item .value { font-size: 20px; color: #444; }

        /* Grid thông tin sức khỏe & ghi chú */
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 35px; }
        .info-card h3 { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
        .info-card p { font-size: 14px; color: #666; line-height: 1.6; }

        /* Lịch sử dịch vụ */
        .service-history h3 { font-size: 18px; font-weight: bold; margin-bottom: 20px; }
        .history-list { max-height: 300px; overflow-y: auto; }
        .history-item {
            display: flex; justify-content: space-between; align-items: center;
            padding: 15px 0; border-bottom: 1px solid #f0f0f0;
        }
        .history-item:last-child { border-bottom: none; }
        .sv-date { font-size: 14px; color: #888; display: block; }
        .sv-name { font-size: 15px; font-weight: 600; color: #333; }
        .sv-price { font-size: 16px; font-weight: bold; color: #000; }

        /* Footer Buttons */
        .footer-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .btn {
            padding: 15px; border-radius: 15px; border: none; font-size: 16px;
            font-weight: bold; cursor: pointer; transition: 0.3s; text-align: center;
            text-decoration: none;
        }
        .btn-edit { background: #e0e0e0; color: #000; }
        .btn-edit:hover { background: #d0d0d0; }
        .btn-close { background: #c0c0c0; color: #000; }
        .btn-close:hover { background: #b0b0b0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="detail-container">
            <h1 class="title-screen">Quản lý khách hàng</h1>

            <div class="profile-header">
                <div class="avatar-box">
                    <asp:Image ID="imgAvatar" runat="server" ImageUrl="../assets/anh/logo.png" />
                </div>
                <div class="basic-info">
                    <h2>Tên khách hàng :</h2>
                    <div class="customer-name"><asp:Literal ID="ltrFullName" runat="server"></asp:Literal></div>
                    <span class="customer-phone">Số điện thoại : <asp:Literal ID="ltrPhone" runat="server"></asp:Literal></span>
                    
                    <div class="stats-row">
                        <div class="stat-item">
                            <span class="label">Hạng</span>
                            <span class="value"><asp:Literal ID="ltrRank" runat="server"></asp:Literal></span>
                        </div>
                        <div class="stat-item">
                            <span class="label">Điểm tích lũy</span>
                            <span class="value"><asp:Literal ID="ltrPoints" runat="server"></asp:Literal></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-card">
                    <h3>Thông tin sức khỏe</h3>
                    <p><asp:Literal ID="ltrHealthInfo" runat="server" Text="Chưa có thông tin"></asp:Literal></p>
                </div>
                <div class="info-card">
                    <h3>Ghi chú nội bộ</h3>
                    <p><asp:Literal ID="ltrInternalNote" runat="server" Text="Không có ghi chú"></asp:Literal></p>
                </div>
            </div>

            <div class="service-history">
                <h3>Lịch sử dịch vụ</h3>
                <div class="history-list">
                    <asp:Repeater ID="rptHistory" runat="server">
                        <ItemTemplate>
                            <div class="history-item">
                                <div>
                                    <span class="sv-date"><%# Eval("ngay_hen", "{0:dd/MM/yyyy}") %></span>
                                    <span class="sv-name"><%# Eval("ten_dich_vu") %></span>
                                </div>
                                <div class="sv-price"><%# string.Format("{0:N0} đ", Eval("tong_tien")) %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="footer-actions">
               <a href='admin_customer_edit.aspx?id=<%# Eval("id") %>' class="btn btn-edit">
               <i class="fa-solid fa-pen-to-square"></i> Chỉnh sửa
               </a>
                <a href="admin_customer.aspx" class="btn btn-close">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>