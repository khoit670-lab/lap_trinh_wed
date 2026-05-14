<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_staff_add.aspx.cs" Inherits="lap_trinh_wed.admin.admin_staff_add" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Thêm nhân sự mới</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f8f9fa; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }

        .add-card {
            background: #fff; width: 600px; border-radius: 30px;
            padding: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .title-screen { font-size: 36px; font-weight: bold; text-align: center; margin-bottom: 35px; color: #000; }

        /* Header: Photo Placeholder + Input Fields */
        .profile-header { display: flex; gap: 25px; margin-bottom: 30px; }
        .photo-placeholder {
            width: 150px; height: 180px; border: 1px solid #ffcad4;
            border-radius: 15px; background: #fff; display: flex; align-items: center; justify-content: center;
        }
        
        .input-group { flex: 1; display: flex; flex-direction: column; gap: 10px; }
        .input-row { display: flex; align-items: center; gap: 10px; }
        .label-text { font-size: 18px; font-weight: 600; white-space: nowrap; width: 130px; }
        
        .txt-input { 
            flex: 1; padding: 8px 12px; border: 1px solid #999; border-radius: 5px; 
            font-size: 16px; outline: none; 
        }

        /* Ghi chú & Ca làm việc */
        .full-width-section { margin-bottom: 25px; }
        .section-label { font-size: 18px; font-weight: bold; margin-bottom: 10px; display: block; }
        .txt-area { 
            width: 100%; padding: 10px; border: 1px solid #999; border-radius: 5px; 
            font-size: 16px; outline: none; height: 40px;
        }

        .shift-display {
            background: #fff; border: 1px solid #f0f0f0; border-radius: 20px;
            padding: 15px 25px; font-size: 18px; color: #333;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        }

        /* Footer Buttons */
        .footer-actions { display: flex; gap: 20px; margin-top: 30px; }
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
        <div class="add-card">
            <h1 class="title-screen">Quản lý Nhân sự</h1>

            <div class="profile-header">
                <div class="photo-placeholder">
                    </div>
                <div class="input-group">
                    <div class="input-row">
                        <span class="label-text">Tên nhân sự :</span>
                        <asp:TextBox ID="txtName" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-text">Số điện thoại :</span>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-text">Chức vụ : .</span>
                        <asp:TextBox ID="txtPosition" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-text">Trạng thái :</span>
                        <asp:TextBox ID="txtStatus" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="full-width-section">
                <span class="section-label">Ghi chú / Đánh giá</span>
                <asp:TextBox ID="txtNotes" runat="server" CssClass="txt-area"></asp:TextBox>
            </div>

            <div class="full-width-section">
                <span class="section-label">Ca làm việc</span>
                <div class="shift-display">
                    <asp:Literal ID="ltrShiftDefault" runat="server" Text="Ca full (7h - 18h)"></asp:Literal>
                </div>
            </div>

            <div class="footer-actions">
                <asp:Button ID="btnAddStaff" runat="server" Text="+ Thêm nhân sự" CssClass="btn" OnClick="btnAddStaff_Click" />
                <a href="admin_staff.aspx" class="btn">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>