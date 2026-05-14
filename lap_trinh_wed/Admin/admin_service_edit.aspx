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
            background: #fff; width: 600px; border-radius: 30px;
            padding: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .title-screen { font-size: 36px; font-weight: bold; text-align: center; margin-bottom: 35px; color: #000; }

        /* Bố cục: Ảnh bên trái, Input bên phải */
        .header-content { display: flex; gap: 25px; margin-bottom: 25px; }
        .image-box {
            width: 150px; height: 180px; border: 1px solid #ffcad4;
            border-radius: 15px; background: #fff; flex-shrink: 0;
        }

        .input-fields { flex: 1; display: flex; flex-direction: column; gap: 12px; }
        .input-group { display: flex; align-items: center; gap: 10px; }
        .input-group label { font-size: 18px; font-weight: bold; white-space: nowrap; }
        
        .txt-input { 
            flex: 1; padding: 8px 12px; border: 1px solid #999; border-radius: 5px; 
            font-size: 16px; outline: none; 
        }

        /* Mô tả bên dưới */
        .description-row { margin-bottom: 30px; }
        .description-row label { font-size: 18px; font-weight: bold; margin-bottom: 10px; display: block; }
        .txt-area { 
            width: 100%; padding: 12px; border: 1px solid #999; border-radius: 5px; 
            font-size: 16px; outline: none; height: 150px; resize: none;
        }

        /* Footer: 2 nút Chỉnh sửa & Đóng */
        .footer-actions { display: flex; gap: 20px; }
        .btn {
            flex: 1; padding: 12px; border-radius: 20px; border: 1px solid #999;
            font-size: 20px; font-weight: bold; cursor: pointer; transition: 0.2s;
            text-align: center; text-decoration: none; color: #000; background: #d9d9d9;
        }
        .btn:hover { background: #ccc; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="edit-card">
            <h1 class="title-screen">Quản lý dịch vụ</h1>

            <div class="header-content">
                <div class="image-box">
                    </div>
                <div class="input-fields">
                    <div class="input-group">
                        <label>Tên dịch vụ :</label>
                        <asp:TextBox ID="txtServiceName" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label>loại :</label>
                        <asp:TextBox ID="txtType" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label>Thời gian :</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label>Giá tiền :</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="description-row">
                <label>Mô tả / Công dụng</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="txt-area" TextMode="MultiLine"></asp:TextBox>
            </div>

            <div class="footer-actions">
                <asp:Button ID="btnSave" runat="server" Text="Lưu Chỉnh sửa" CssClass="btn" OnClick="btnSave_Click" />
                <a href="admin_service.aspx" class="btn">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>