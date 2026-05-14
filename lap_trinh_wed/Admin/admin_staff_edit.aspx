<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_staff_edit.aspx.cs" Inherits="lap_trinh_wed.admin.admin_staff_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Chỉnh sửa nhân sự</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f8f9fa; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }

        .edit-card {
            background: #fff; width: 600px; border-radius: 30px;
            padding: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .title-screen { font-size: 36px; font-weight: bold; text-align: center; margin-bottom: 35px; color: #000; }

        /* Profile Header: Avatar + Editable Inputs */
        .profile-header { display: flex; gap: 25px; margin-bottom: 30px; }
        .avatar-frame {
            width: 150px; height: 180px; border: 1px solid #ffcad4;
            border-radius: 15px; background: #fff; display: flex; align-items: center; justify-content: center;
        }
        
        .input-fields { flex: 1; display: flex; flex-direction: column; gap: 12px; }
        .input-row { display: flex; align-items: center; gap: 10px; }
        .label-style { font-size: 19px; font-weight: 600; white-space: nowrap; width: 140px; }
        
        .txt-box { 
            flex: 1; padding: 6px 10px; border: 1px solid #999; border-radius: 5px; 
            font-size: 18px; outline: none; background: #fff;
        }

        /* Notes and Shift Sections */
        .section-box { margin-bottom: 25px; }
        .label-bold { font-size: 19px; font-weight: bold; margin-bottom: 10px; display: block; }
        .txt-note { 
            width: 100%; padding: 10px; border: 1px solid #999; border-radius: 5px; 
            font-size: 16px; outline: none; height: 45px;
        }

        .shift-container {
            background: #fff; border: 1px solid #f2f2f2; border-radius: 20px;
            padding: 15px 25px; font-size: 18px; color: #333;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        }

        /* Action Buttons */
        .btn-group { display: flex; gap: 25px; margin-top: 35px; }
        .btn-action {
            flex: 1; padding: 12px; border-radius: 20px; border: 1px solid #888;
            font-size: 20px; font-weight: bold; cursor: pointer; transition: 0.2s;
            text-align: center; text-decoration: none; color: #000; background: #d3d3d3;
        }
        .btn-action:hover { background: #c5c5c5; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="edit-card">
            <h1 class="title-screen">Quản lý Nhân sự</h1>

            <div class="profile-header">
                <div class="avatar-frame">
                    </div>
                <div class="input-fields">
                    <div class="input-row">
                        <span class="label-style">Tên nhân sự :</span>
                        <asp:TextBox ID="txtStaffName" runat="server" CssClass="txt-box" Text="Nguyễn Thị Lan"></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-style">Số điện thoại :</span>
                        <asp:TextBox ID="txtStaffPhone" runat="server" CssClass="txt-box" Text="0987 123 456."></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-style">Chức vụ :</span>
                        <asp:TextBox ID="txtStaffPosition" runat="server" CssClass="txt-box" Text="lễ tân."></asp:TextBox>
                    </div>
                    <div class="input-row">
                        <span class="label-style">Trạng thái :</span>
                        <asp:TextBox ID="txtStaffStatus" runat="server" CssClass="txt-box" Text="Đang làm việc"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="section-box">
                <span class="label-bold">Ghi chú / Đánh giá</span>
                <asp:TextBox ID="txtStaffEvaluation" runat="server" CssClass="txt-note" Text="Thân thiện, giao tiếp tốt."></asp:TextBox>
            </div>

            <div class="section-box">
                <span class="label-bold">Ca làm việc</span>
                <div class="shift-container">
                    <asp:Literal ID="ltrStaffShift" runat="server" Text="Ca full (7h - 18h)"></asp:Literal>
                </div>
            </div>

            <div class="btn-group">
                <asp:Button ID="btnUpdate" runat="server" Text="Lưu Chỉnh sửa" CssClass="btn-action" OnClick="btnUpdate_Click" />
                <a href="admin_staff.aspx" class="btn-action">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>