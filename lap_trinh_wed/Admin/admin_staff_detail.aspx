<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_service_detail.aspx.cs" Inherits="lap_trinh_wed.admin.admin_service_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Chi tiết dịch vụ</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Style tập trung vào Card nằm giữa màn hình như mockup nhân sự */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { 
            background-color: #f8f9fa; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            padding: 20px; 
        }

        .detail-card {
            background: #fff; width: 600px; border-radius: 30px;
            padding: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .title-screen { font-size: 36px; font-weight: bold; text-align: center; margin-bottom: 35px; color: #000; }

        /* Header: Ảnh dịch vụ + Thông tin chính */
        .profile-header { display: flex; gap: 30px; margin-bottom: 35px; align-items: flex-start; }
        .avatar-box {
            width: 150px; height: 180px; border: 1px solid #ffcad4;
            border-radius: 15px; background: #fff; display: flex; align-items: center; justify-content: center;
        }
        .avatar-box i { font-size: 80px; color: #f0f0f0; }

        .info-text h2 { font-size: 24px; font-weight: bold; margin-bottom: 15px; }
        .info-line { font-size: 19px; margin-bottom: 12px; display: block; color: #333; }
        .info-line strong { font-weight: 600; }

        /* Phần mô tả / công dụng */
        .section-title { font-size: 20px; font-weight: bold; margin-bottom: 10px; display: block; }
        .note-text { font-size: 16px; color: #666; margin-bottom: 25px; line-height: 1.5; }

        /* Nút Footer màu xám đặc trưng */
        .footer-actions { display: flex; justify-content: center; margin-top: 20px; }
        .btn {
            width: 50%; padding: 15px; border-radius: 20px; border: 1px solid #999;
            font-size: 20px; font-weight: bold; cursor: pointer; transition: 0.3s;
            text-align: center; text-decoration: none; color: #000; background: #d9d9d9;
        }
        .btn:hover { background: #ccc; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="detail-card">
            <h1 class="title-screen">Quản lý dịch vụ</h1>

            <div class="profile-header">
                <div class="avatar-box">
                    <i class="fa-solid fa-spa"></i>
                </div>
                <div class="info-text">
                    <h2>Tên dịch vụ : <asp:Literal ID="ltrServiceName" runat="server" Text="chăm sóc da"></asp:Literal></h2>
                    <span class="info-line">loại : <strong><asp:Literal ID="ltrType" runat="server" Text="Chăm sóc da."></asp:Literal></strong></span>
                    <span class="info-line">Thời gian : <strong><asp:Literal ID="ltrTime" runat="server" Text="60'"></asp:Literal></strong></span>
                    <span class="info-line">Giá tiền : <strong><asp:Literal ID="ltrPrice" runat="server" Text="1.000.000"></asp:Literal></strong></span>
                </div>
            </div>

            <div class="evaluation-section">
                <span class="section-title">Mô tả / Công dụng :</span>
                <p class="note-text">
                    <asp:Literal ID="ltrDesc" runat="server" Text="Làm cho da sáng hơn và mịn màng"></asp:Literal>
                </p>
            </div>

            <div class="footer-actions">
                <a href="admin_service.aspx" class="btn">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>