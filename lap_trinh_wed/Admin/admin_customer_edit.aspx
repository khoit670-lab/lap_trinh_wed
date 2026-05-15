<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_customer_edit.aspx.cs" Inherits="lap_trinh_wed.admin.admin_customer_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Chỉnh sửa khách hàng</title>
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
            background: var(--purple);
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
                <h1 class="title-screen">Chỉnh sửa khách hàng</h1>

                <div class="input-fields">
                    <div class="input-group">
                        <label for="txtName">Họ và tên</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>

                    <div class="input-group">
                        <label for="txtPhone">Số điện thoại</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                </div>

                <div class="stats-grid">
                    <div class="input-group">
                        <label for="txtRank">Hạng khách hàng</label>
                        <asp:TextBox ID="txtRank" runat="server" CssClass="txt-input"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label for="txtPoints">Điểm tích lũy</label>
                        <asp:TextBox ID="txtPoints" runat="server" CssClass="txt-input" TextMode="Number"></asp:TextBox>
                    </div>
                </div>

                <div class="notes-grid">
                    <div class="input-group">
                        <label for="txtHealth">Thông tin sức khỏe</label>
                        <asp:TextBox ID="txtHealth" runat="server" TextMode="MultiLine" CssClass="txt-area" 
                            placeholder="Ghi chú về tình trạng da, dị ứng, bệnh lý..."></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <label for="txtInternalNote">Ghi chú nội bộ</label>
                        <asp:TextBox ID="txtInternalNote" runat="server" TextMode="MultiLine" CssClass="txt-area" 
                            placeholder="Ưu tiên dịch vụ, sở thích, lưu ý đặc biệt..."></asp:TextBox>
                    </div>
                </div>

                <div class="footer-actions">
                    <asp:Button ID="btnSave" runat="server" Text="Lưu thay đổi" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <a href="admin_customer.aspx" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>