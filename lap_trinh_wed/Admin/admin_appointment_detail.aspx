<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_appointment_detail.aspx.cs" Inherits="lap_trinh_wed.admin.appointment_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Chi tiết lịch hẹn - Lily Spa</title>
    <style>
        body { background-color: #fcfcfc; font-family: 'Segoe UI', sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        
        .detail-card {
            background: #fff; width: 500px; padding: 40px; border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #eee;
        }

        .detail-card h1 { font-size: 32px; text-align: center; margin-bottom: 30px; font-weight: bold; }

        .info-group { margin-bottom: 20px; }
        .info-label { font-weight: bold; font-size: 18px; color: #333; display: block; margin-bottom: 5px; }
        .info-content { font-size: 17px; color: #666; padding-left: 10px; }

        /* Nút bấm */
        .action-group { display: flex; justify-content: space-between; margin-top: 40px; gap: 15px; }
        .btn {
            flex: 1; padding: 15px; border-radius: 12px; border: none;
            font-weight: bold; font-size: 16px; cursor: pointer; transition: 0.3s; text-align: center;
        }
        .btn-checkin { background-color: #52c41a; color: white; }
        .btn-cancel { background-color: #ff4d4f; color: white; }
        .btn-close { background-color: #d9d9d9; color: #333; text-decoration: none; display: inline-block; }
        
        .btn:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="detail-card">
            <h1>Quản lý lịch hẹn</h1>

            <div class="info-group">
                <span class="info-label">Thời gian :</span>
                <div class="info-content">16/04/2026 - 10:00</div>
            </div>

            <div class="info-group">
                <span class="info-label">Khách hàng :</span>
                <div class="info-content">ABCDFFF</div>
            </div>

            <div class="info-group">
                <span class="info-label">Số điện thoại :</span>
                <div class="info-content">09899999999</div>
            </div>

            <div class="info-group">
                <span class="info-label">Dịch vụ :</span>
                <div class="info-content">Chăm sóc da Collagen Glow</div>
            </div>

            <div class="info-group">
                <span class="info-label">Nhân viên :</span>
                <div class="info-content">Chị Lan</div>
            </div>

            <div class="info-group">
                <span class="info-label">Trạng thái :</span>
                <div class="info-content">Đã xác nhận</div>
            </div>

            <div class="action-group">
                <asp:Button ID="btnCheckin" runat="server" Text="Check-in" CssClass="btn btn-checkin" />
                <asp:Button ID="btnCancel" runat="server" Text="Hủy lịch" CssClass="btn btn-cancel" />
                <a href="admin_appointment.aspx" class="btn btn-close">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>