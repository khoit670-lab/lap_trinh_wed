<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_appointment_detail.aspx.cs" Inherits="lap_trinh_wed.admin.admin_appointment_detail" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết lịch hẹn</title>
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
            align-items: center;
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

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .status-cho { background: #eff6ff; color: #1e40af; }
        .status-xac { background: #ecfdf5; color: #166534; }
        .status-dang { background: #fef3c7; color: #92400e; }
        .status-hoan { background: #f0fdf4; color: #166534; }
        .status-huy { background: #fef2f2; color: #dc2626; }

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
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }

        .btn-success { background: var(--success); color: white; }
        .btn-danger { background: var(--danger); color: white; }
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
                <h1 class="title">Chi tiết lịch hẹn</h1>

                <div class="info-row">
                    <span class="info-label">Thời gian</span>
                    <div class="info-value"><span id="lblThoiGian" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Khách hàng</span>
                    <div class="info-value"><span id="lblKhachHang" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Số điện thoại</span>
                    <div class="info-value"><span id="lblSoDienThoai" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Dịch vụ</span>
                    <div class="info-value"><span id="lblDichVu" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Nhân viên</span>
                    <div class="info-value"><span id="lblNhanVien" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Tổng tiền</span>
                    <div class="info-value"><span id="lblTongTien" runat="server"></span></div>
                </div>

                <div class="info-row">
                    <span class="info-label">Trạng thái</span>
                    <div class="info-value">
                        <span id="lblTrangThai" runat="server" class="status-badge">
                            <span id="lblTrangThaiText" runat="server"></span>
                        </span>
                    </div>
                </div>

                <div class="info-row">
                    <span class="info-label">Cập nhật</span>
                    <div class="info-value"><span id="lblUpdatedAt" runat="server"></span></div>
                </div>

                <div class="actions">
                    <asp:LinkButton ID="btnCheckin" runat="server" CssClass="btn btn-success" OnClick="btnCheckin_Click">
                        Check-in
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click">
                        Hủy
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnComplete" runat="server" CssClass="btn btn-purple" OnClick="btnComplete_Click">
                        Hoàn thành
                    </asp:LinkButton>

                    <a href="admin_appointment.aspx" class="btn btn-secondary">
                        Quay lại
                    </a>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlNoData" runat="server" CssClass="card no-data" Visible="false">
                <h2>Không tìm thấy lịch hẹn</h2>
                <p>ID không hợp lệ hoặc lịch hẹn đã bị xóa</p>
                <a href="admin_appointment.aspx" class="btn btn-success">
                    Quay lại danh sách
                </a>
            </asp:Panel>
        </div>
    </form>
</body>
</html>