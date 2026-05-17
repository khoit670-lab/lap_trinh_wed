<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_staff_add.aspx.cs" Inherits="lap_trinh_wed.admin.admin_staff_add" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Thêm nhân sự mới</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: system-ui, -apple-system, sans-serif; }
        body { 
            background: var(--gray-50);
            font-family: system-ui, -apple-system, sans-serif;
            color: var(--gray-900);
            padding: 2rem;
            line-height: 1.5;
            min-height: 100vh;
        }

        :root {
            --primary: #3b82f6;
            --success: #10b981;
            --danger: #ef4444;
            --purple: #8b5cf6;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-900: #111827;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .edit-card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem;
            box-shadow: var(--shadow);
            border: 1px solid var(--gray-200);
        }

        .title-screen { 
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--gray-900);
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: -0.025em;
        }

        .input-fields { 
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .input-group label { 
            font-weight: 600;
            color: var(--gray-700);
            font-size: 1rem;
        }
        
        .txt-input, .txt-area { 
            padding: 0.875rem 1rem;
            border: 2px solid var(--gray-200);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.2s;
            background: white;
            font-weight: 500;
        }

        .txt-input:focus, .txt-area:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .notes-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .txt-area { 
            height: 120px;
            resize: vertical;
            font-family: inherit;
        }

        .status-select {
            padding: 0.875rem 1rem;
            border: 2px solid var(--gray-200);
            border-radius: 8px;
            font-size: 1rem;
            background: white;
            font-weight: 500;
            cursor: pointer;
        }

        .status-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
        }

        .footer-actions { 
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn {
            padding: 0.875rem 2rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.95rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: var(--shadow-sm);
            flex: 1;
            max-width: 200px;
            text-align: center;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .btn-primary { 
            background: var(--success);
            color: white;
        }

        .btn-secondary { 
            background: var(--gray-100); 
            color: var(--gray-700); 
            border: 1px solid var(--gray-200);
        }

        @media (max-width: 640px) {
            body { padding: 1rem; }
            .edit-card { padding: 2rem; }
            .title-screen { font-size: 1.875rem; }
            .stats-grid, .notes-grid { grid-template-columns: 1fr; }
            .footer-actions { flex-direction: column; }
            .btn { max-width: none; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="edit-card">
                <h1 class="title-screen">Thêm nhân sự mới</h1>

                <div class="input-fields">
                    <div class="input-group">
                        <label for="txtName">Họ và tên <span style="color: var(--danger);">*</span></label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="txt-input" 
                            placeholder="Nhập họ và tên đầy đủ"></asp:TextBox>
                    </div>

                    <div class="input-group">
                        <label for="txtPhone">Số điện thoại <span style="color: var(--danger);">*</span></label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="txt-input" 
                            placeholder="0987xxx xxx"></asp:TextBox>
                    </div>
                </div>

                <div class="stats-grid">
                    <div class="input-group">
                        <label for="txtPosition">Chức vụ</label>
                        <asp:TextBox ID="txtPosition" runat="server" CssClass="txt-input" 
                            placeholder="VD: Lễ tân, Kỹ thuật viên..."></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label for="ddlStatus">Trạng thái <span style="color: var(--danger);">*</span></label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-select">
                            <asp:ListItem Value="" Text="-- Chọn trạng thái --"></asp:ListItem>
                            <asp:ListItem Value="Đang làm">Đang làm</asp:ListItem>
                            <asp:ListItem Value="Tạm nghỉ">Tạm nghỉ</asp:ListItem>
                            <asp:ListItem Value="Nghỉ việc">Nghỉ việc</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="notes-grid">
                    <div class="input-group">
                        <label for="txtShift">Ca làm việc</label>
                        <asp:TextBox ID="txtShift" runat="server" CssClass="txt-input" 
                            placeholder="VD: Ca sáng (7h-14h), Ca full..."></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label for="txtNote">Ghi chú nội bộ</label>
                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" CssClass="txt-area" 
                            placeholder="Đánh giá ban đầu, lưu ý đặc biệt..."></asp:TextBox>
                    </div>
                </div>

                <div class="footer-actions">
                    <asp:Button ID="btnSave" runat="server" Text="Thêm nhân sự" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <a href="admin_staff.aspx" class="btn btn-secondary">Hủy bỏ</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>