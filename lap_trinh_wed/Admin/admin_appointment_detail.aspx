<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_appointment_detail.aspx.cs" Inherits="lap_trinh_wed.admin.appointment_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Chi tiết lịch hẹn - Lily Spa</title>
    <style>
        body { 
            background-color: #fcfcfc; 
            font-family: 'Segoe UI', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0; 
        }

        .detail-card {
            background: #fff; 
            width: 500px; 
            padding: 40px; 
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            border: 1px solid #eee;
        }

        .detail-card h1 { 
            font-size: 32px; 
            text-align: center; 
            margin-bottom: 30px; 
            font-weight: bold; 
            color: #f04581;
        }

        .info-group { 
            margin-bottom: 20px; 
        }
        .info-label { 
            font-weight: bold; 
            font-size: 18px; 
            color: #333; 
            display: block; 
            margin-bottom: 5px; 
        }
        .info-content { 
            font-size: 17px; 
            color: #666; 
            padding-left: 10px; 
        }

        /* Status badge */
        .status-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            color: white;
        }
        .status-cho { background: #ff9800; }
        .status-xac { background: #52c41a; }
        .status-dang { background: #1890ff; }
        .status-hoan { background: #52c41a; }
        .status-huy { background: #ff4d4f; }

        /* Nút bấm */
        .action-group { 
            display: flex; 
            justify-content: space-between; 
            margin-top: 40px; 
            gap: 15px; 
        }
        .btn {
            flex: 1; 
            padding: 15px; 
            border-radius: 12px; 
            border: none;
            font-weight: bold; 
            font-size: 16px; 
            cursor: pointer; 
            transition: 0.3s; 
            text-align: center;
        }
        .btn-checkin { 
            background-color: #52c41a; 
            color: white; 
        }
        .btn-cancel { 
            background-color: #ff4d4f; 
            color: white; 
        }
        .btn-close { 
            background-color: #d9d9d9; 
            color: #333; 
            text-decoration: none; 
            display: inline-block; 
        }

        .btn:hover:not(.btn-close) { 
            opacity: 0.8; 
            transform: translateY(-1px);
        }
        .btn-close:hover { 
            background-color: #bfbfbf; 
        }

        .no-data {
            text-align: center;
            padding: 60px 40px;
            color: #999;
        }
        .no-data i {
            font-size: 64px;
            margin-bottom: 20px;
            color: #ddd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="pnlDetail" runat="server" CssClass="detail-card" Visible="false">
            <h1>📋 Chi tiết lịch hẹn</h1>

            <div class="info-group">
                <span class="info-label">⏰ Thời gian:</span>
                <div class="info-content" id="lblThoiGian" runat="server"></div>
            </div>

            <div class="info-group">
                <span class="info-label">👤 Khách hàng:</span>
                <div class="info-content" id="lblKhachHang" runat="server"></div>
            </div>

            <div class="info-group">
                <span class="info-label">📱 Số điện thoại:</span>
                <div class="info-content" id="lblSoDienThoai" runat="server"></div>
            </div>

            <div class="info-group">
                <span class="info-label">💆‍♀️ Dịch vụ:</span>
                <div class="info-content" id="lblDichVu" runat="server"></div>
            </div>

            <div class="info-group">
                <span class="info-label">👩‍💼 Nhân viên:</span>
                <div class="info-content" id="lblNhanVien" runat="server"></div>
            </div>

            <div class="info-group">
                <span class="info-label">📊 Trạng thái:</span>
                <div class="info-content">
                    <span id="lblTrangThai" runat="server" class="status-badge"></span>
                </div>
            </div>

            <div class="action-group">
                <asp:Button ID="btnCheckin" runat="server" Text="✅ Check-in" 
                           CssClass="btn btn-checkin" OnClick="btnCheckin_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="❌ Hủy lịch" 
                           CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
                <a href="admin_appointment.aspx" class="btn btn-close">✕ Đóng</a>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoData" runat="server" CssClass="detail-card no-data" Visible="false">
            <i class="fa-solid fa-calendar-xmark"></i>
            <div style="font-size: 20px; margin-top: 10px;">Không tìm thấy lịch hẹn!</div>
            <a href="admin_appointment.aspx" class="btn" style="background: #f04581; color: white; 
                margin-top: 20px; display: inline-block; width: auto; padding: 12px 30px;">
                Quay lại danh sách
            </a>
        </asp:Panel>
    </form>
</body>
</html>