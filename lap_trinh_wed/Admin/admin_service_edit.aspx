<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_service_edit.aspx.cs" Inherits="lap_trinh_wed.admin.admin_service_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Chỉnh sửa dịch vụ</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { 
            background-color: #f8f9fa; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            padding: 20px; 
        }

        .edit-card {
            background: #fff; width: 700px; max-width: 90vw; border-radius: 30px;
            padding: 40px; box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .title-screen { 
            font-size: 36px; font-weight: bold; text-align: center; 
            margin-bottom: 35px; color: #000; 
        }

        /* Bố cục: Icon bên trái, Input bên phải */
        .header-content { 
            display: flex; gap: 25px; margin-bottom: 35px; align-items: flex-start; 
        }
        .service-icon {
            width: 150px; height: 180px; border: 2px solid #ffcad4;
            border-radius: 20px; background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
            flex-shrink: 0; display: flex; align-items: center; justify-content: center;
        }
        .service-icon i { font-size: 70px; color: #ff4d6d; }

        .input-fields { flex: 1; display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .input-group { 
            display: flex; flex-direction: column; gap: 8px; 
        }
        .input-group.full-width { grid-column: 1 / -1; }
        .input-group label { 
            font-size: 16px; font-weight: 600; color: #333; 
        }
        
        .txt-input { 
            padding: 14px 16px; border: 2px solid #e1e5e9; border-radius: 12px; 
            font-size: 16px; font-weight: 500; outline: none; 
            transition: all 0.3s; background: #fafbfc;
        }
        .txt-input:focus {
            border-color: #667eea; box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            background: white;
        }

        /* Mô tả bên dưới */
        .description-row { 
            margin-bottom: 40px; grid-column: 1 / -1; 
        }
        .description-row label { 
            font-size: 18px; font-weight: bold; margin-bottom: 12px; 
            display: block; color: #333; 
        }
        .txt-area { 
            width: 100%; padding: 16px; border: 2px solid #e1e5e9; 
            border-radius: 12px; font-size: 16px; font-weight: 500;
            outline: none; height: 160px; resize: vertical; background: #fafbfc;
            line-height: 1.6;
        }
        .txt-area:focus {
            border-color: #667eea; box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            background: white;
        }

        /* Footer: 2 nút */
        .footer-actions { 
            display: flex; gap: 20px; 
        }
        .btn {
            flex: 1; padding: 16px 24px; border-radius: 20px; border: none;
            font-size: 18px; font-weight: bold; cursor: pointer; transition: 0.3s;
            text-align: center; text-decoration: none; color: white;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        .btn-primary:hover { 
            transform: translateY(-2px); box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #f1f3f4; color: #666; font-weight: 600;
            border: 2px solid #e1e5e9;
        }
        .btn-secondary:hover { 
            background: #e8eaed; transform: translateY(-1px);
        }

        @media (max-width: 768px) {
            .edit-card { width: 95vw; padding: 30px 20px; margin: 10px; }
            .title-screen { font-size: 28px; }
            .input-fields { grid-template-columns: 1fr; gap: 16px; }
            .header-content { flex-direction: column; text-align: center; }
            .service-icon { margin: 0 auto; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="edit-card">
            <h1 class="title-screen">Chỉnh sửa dịch vụ</h1>

            <div class="header-content">
                <div class="service-icon">
                    <i class="fas fa-spa"></i>
                </div>
                <div class="input-fields">
                    <div class="input-group">
                        <label>Tên dịch vụ</label>
                        <asp:TextBox ID="txtServiceName" runat="server" CssClass="txt-input" 
                            placeholder="VD: Massage toàn thân"></asp:TextBox>
                    </div>
                    
                    <div class="input-group">
                        <label>Loại dịch vụ</label>
                        <asp:TextBox ID="txtType" runat="server" CssClass="txt-input" 
                            placeholder="VD: Massage, Chăm sóc da..."></asp:TextBox>
                    </div>
                    
                    <div class="input-group">
                        <label>Thời gian (phút)</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="txt-input" 
                            placeholder="VD: 60"></asp:TextBox>
                    </div>
                    
                    <div class="input-group">
                        <label>Giá tiền (VNĐ)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="txt-input" 
                            placeholder="VD: 500000"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="description-row">
                <label>Mô tả / Công dụng</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="txt-area" 
                    TextMode="MultiLine" placeholder="Mô tả chi tiết về dịch vụ, lợi ích, lưu ý..."></asp:TextBox>
            </div>

            <div class="footer-actions">
                <asp:Button ID="btnSave" runat="server" Text="💾 Lưu thay đổi" 
                    CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <a href="admin_service.aspx" class="btn btn-secondary">❌ Hủy</a>
            </div>
        </div>
    </form>
</body>
</html>