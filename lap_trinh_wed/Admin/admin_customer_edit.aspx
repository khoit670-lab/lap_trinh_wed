<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_customer_edit.aspx.cs" Inherits="lap_trinh_wed.admin.admin_customer_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Lily Spa - Chỉnh sửa khách hàng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #f9f9f9; display: flex; justify-content: center; padding: 30px; }

        .edit-card {
            background: #fff; width: 620px; border-radius: 25px;
            padding: 35px; box-shadow: 0 8px 30px rgba(0,0,0,0.05);
            border: 1px solid #eee;
        }

        .title-main { font-size: 34px; font-weight: bold; text-align: center; margin-bottom: 30px; }

        /* Khung ảnh & Thông tin chính */
        .flex-container { display: flex; gap: 25px; margin-bottom: 25px; }
        .photo-frame {
            width: 150px; height: 180px; border: 1px solid #ffb6c1;
            border-radius: 12px; display: flex; align-items: center; justify-content: center;
        }
        .photo-frame i { font-size: 80px; color: #f0f0f0; } /* Icon placeholder */

        .inputs-right { flex: 1; }
        .label-style { font-size: 19px; font-weight: 600; margin-bottom: 5px; display: block; }
        .input-box {
            width: 100%; padding: 10px; border: 1px solid #999; 
            border-radius: 5px; font-size: 18px; margin-bottom: 15px;
        }

        /* Hạng & Điểm */
        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
        .stat-item { text-align: center; }
        .input-center { text-align: center; width: 80%; }

        /* Ghi chú */
        .notes-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 25px; }
        .note-title { font-size: 17px; font-weight: bold; margin-bottom: 8px; text-align: center; }
        .textarea-style {
            width: 100%; height: 90px; padding: 10px; border: 1px solid #999;
            border-radius: 8px; resize: none; font-size: 14px;
        }

        /* Danh sách lịch sử (Chế độ xem lại) */
        .history-label { font-size: 16px; font-weight: bold; margin-bottom: 10px; }
        .history-box { display: flex; flex-direction: column; gap: 10px; }
        .history-row {
            background: #fff; padding: 12px 20px; border-radius: 15px;
            display: flex; justify-content: space-between; border: 1px solid #f0f0f0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .sv-text { font-size: 15px; font-weight: 600; }
        .sv-sub { font-size: 13px; color: #888; }

        /* Nút bấm chuẩn theo ảnh */
        .btn-group { display: flex; gap: 20px; margin-top: 30px; }
        .btn {
            flex: 1; padding: 12px; border-radius: 15px; border: 1px solid #888;
            font-size: 19px; font-weight: bold; cursor: pointer; transition: 0.2s;
            background: #d3d3d3; color: #000; text-align: center; text-decoration: none;
        }
        .btn:hover { background: #c0c0c0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="edit-card">
            <h1 class="title-main">Quản lý khách hàng</h1>

            <div class="flex-container">
                <div class="photo-frame">
                    <i class="fa-solid fa-image"></i>
                </div>
                <div class="inputs-right">
                    <label class="label-style">Tên khách hàng :</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="input-box" Text="ABCDDD"></asp:TextBox>

                    <label class="label-style">Số điện thoại :</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="input-box" Text="0000000009"></asp:TextBox>
                </div>
            </div>

            <div class="stats-grid">
                <div class="stat-item">
                    <label class="label-style">Hạng</label>
                    <asp:TextBox ID="txtRank" runat="server" CssClass="input-box input-center" Text="Vàng"></asp:TextBox>
                </div>
                <div class="stat-item">
                    <label class="label-style">Điểm tích lũy</label>
                    <asp:TextBox ID="txtPoints" runat="server" CssClass="input-box input-center" Text="1250"></asp:TextBox>
                </div>
            </div>

            <div class="notes-grid">
                <div>
                    <div class="note-title">Thông tin sức khỏe</div>
                    <asp:TextBox ID="txtHealth" runat="server" TextMode="MultiLine" CssClass="textarea-style" 
                        Text="Da hỗn hợp, dễ bị mụn viêm, dị ứng với một số loại tinh dầu"></asp:TextBox>
                </div>
                <div>
                    <div class="note-title">Ghi chú nội bộ</div>
                    <asp:TextBox ID="txtInternalNote" runat="server" TextMode="MultiLine" CssClass="textarea-style" 
                        Text="Khách VIP, thích dịch vụ collagen và massage vai gáy"></asp:TextBox>
                </div>
            </div>

            <div class="history-label">Lịch sử dịch vụ</div>
            <div class="history-box">
                <div class="history-row">
                    <div><div class="sv-sub">10/04/2026</div><div class="sv-text">Massage thư giãn toàn thân</div></div>
                    <div class="sv-text">800.000 đ</div>
                </div>
                <div class="history-row">
                    <div><div class="sv-sub">10/04/2026</div><div class="sv-text">Chăm số da</div></div>
                    <div class="sv-text">1.200.000 đ</div>
                </div>
            </div>

            <div class="btn-group">
                <asp:Button ID="btnSave" runat="server" Text="Lưu Thông tin" CssClass="btn" OnClick="btnSave_Click" />
                <a href="admin_customer.aspx" class="btn">Đóng</a>
            </div>
        </div>
    </form>
</body>
</html>