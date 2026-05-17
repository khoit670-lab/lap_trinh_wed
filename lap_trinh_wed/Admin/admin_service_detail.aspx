<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_service_detail.aspx.cs" Inherits="lap_trinh_wed.admin.admin_service_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết dịch vụ</title>
    <style>
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
            --pink: #f04581;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { 
            background: var(--gray-50);
            font-family: system-ui, -apple-system, sans-serif;
            color: var(--gray-900);
            padding: 2rem;
            line-height: 1.5;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem;
            box-shadow: var(--shadow);
            border: 1px solid var(--gray-200);
        }

        .title {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--gray-900);
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: -0.025em;
        }

        .info-row {
            display: flex;
            align-items: flex-start;
            padding: 1.25rem 0;
            border-bottom: 1px solid var(--gray-200);
        }

        .info-row:last-child { border-bottom: none; }

        .info-label {
            font-weight: 500;
            color: var(--gray-700);
            min-width: 140px;
            font-size: 0.95rem;
        }

        .info-value {
            flex: 1;
            font-weight: 500;
            color: var(--gray-900);
            font-size: 1rem;
        }

        .service-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--purple), #a78bfa);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .status-active { 
            background: #ecfdf5; 
            color: #166534; 
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            border: 1px solid #bbf7d0;
        }

        .status-inactive { 
            background: #fef2f2; 
            color: #dc2626; 
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            border: 1px solid #fecaca;
        }

        .description-section {
            margin-top: 2.5rem;
            padding-top: 2rem;
            border-top: 1px solid var(--gray-200);
        }

        .description-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 1.5rem;
        }

        .description-content {
            color: var(--gray-700);
            line-height: 1.7;
            font-size: 1.05rem;
        }

        .actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2.5rem;
            padding-top: 2rem;
            border-top: 1px solid var(--gray-200);
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: var(--shadow-sm);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .btn-purple { background: var(--purple); color: white; }
        .btn-secondary { 
            background: var(--gray-100); 
            color: var(--gray-700); 
            border: 1px solid var(--gray-200);
        }

        .no-data {
            text-align: center;
            padding: 4rem 2rem;
        }

        .no-data h2 { 
            font-size: 1.5rem; 
            color: var(--gray-900); 
            margin-bottom: 0.5rem;
        }

        .no-data p { 
            color: var(--gray-600); 
            margin-bottom: 2rem;
        }

        @media (max-width: 640px) {
            body { padding: 1rem; }
            .card { padding: 2rem; }
            .title { font-size: 1.875rem; }
            .info-row { flex-direction: column; align-items: flex-start; gap: 0.25rem; padding: 1rem 0; }
            .info-label { min-width: auto; }
            .actions { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <asp:Panel ID="pnlDetail" runat="server" CssClass="card" Visible="false">
                <h1 class="title">Chi tiết dịch vụ</h1>

                <div class="info-row">
                    <div class="service-icon">
                        <i class="fas fa-spa"></i>
                    </div>
                    <div style="flex: 1;">
                        <span class="info-label">Tên dịch vụ</span>
                        <div class="info-value">
                            <asp:Literal ID="ltrServiceName" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>

                <div class="info-row">
                    <span class="info-label">Loại dịch vụ</span>
                    <div class="info-value">
                        <asp:Literal ID="ltrType" runat="server"></asp:Literal>
                    </div>
                </div>

                <div class="info-row">
                    <span class="info-label">Thời gian</span>
                    <div class="info-value">
                        <asp:Literal ID="ltrTime" runat="server"></asp:Literal>
                    </div>
                </div>

                <div class="info-row">
                    <span class="info-label">Giá tiền</span>
                    <div class="info-value">
                        <asp:Literal ID="ltrPrice" runat="server"></asp:Literal>
                    </div>
                </div>

                <div class="info-row">
                    <span class="info-label">Trạng thái</span>
                    <div class="info-value">
                        <span id="lblTrangThai" runat="server" class="status-active">
                            <asp:Literal ID="ltrStatus" runat="server" Text="Đang hoạt động"></asp:Literal>
                        </span>
                    </div>
                </div>

                <div class="description-section">
                    <h2 class="description-title">Mô tả / Công dụng</h2>
                    <div class="description-content">
                        <asp:Literal ID="ltrDesc" runat="server"></asp:Literal>
                    </div>
                </div>

                <div class="actions">
                    <a href='<%# "admin_service_edit.aspx?id=" + Request.QueryString["id"] %>' class="btn btn-purple">
                        ✏️ Chỉnh sửa
                    </a>
                    <a href="admin_service.aspx" class="btn btn-secondary">
                        Quay lại
                    </a>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlNoData" runat="server" CssClass="card no-data" Visible="false">
                <h2>Không tìm thấy dịch vụ</h2>
                <p>ID không hợp lệ hoặc dịch vụ đã bị xóa</p>
                <a href="admin_service.aspx" class="btn btn-purple">
                    Quay lại danh sách
                </a>
            </asp:Panel>
        </div>
    </form>
</body>
</html>