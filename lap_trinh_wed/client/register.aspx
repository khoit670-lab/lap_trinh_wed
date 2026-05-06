<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="lap_trinh_wed.client.register" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lily Spa</title>
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <form id="form1" runat="server" class="max-w-md w-full mx-4">
        <div class="bg-white rounded-3xl shadow-xl overflow-hidden">
            
            <!-- Header -->
            <div class="bg-pink-600 text-white text-center py-6">
                <h1 class="text-3xl font-bold">Lily Spa</h1>
                <p class="text-pink-100 mt-1">Đăng ký tài khoản</p>
            </div>

            <div class="p-8">
                <div class="space-y-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Họ và tên</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="w-full px-5 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500" placeholder="Nhập họ và tên"></asp:TextBox>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Số Điện Thoại</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="w-full px-5 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500" placeholder="Nhập số điện thoại" TextMode="Phone"></asp:TextBox>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="w-full px-5 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500" placeholder="Nhập mật khẩu" TextMode="Password"></asp:TextBox>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Xác Nhận mật khẩu</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="w-full px-5 py-3 border border-gray-300 rounded-2xl focus:outline-none focus:border-pink-500" placeholder="Nhập lại mật khẩu" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="flex items-center gap-2">
                        <asp:CheckBox ID="chkTerms" runat="server" CssClass="w-5 h-5 accent-pink-600" />
                        <label for="chkTerms" class="text-sm text-gray-600">Tôi đồng ý với các điều khoản</label>
                    </div>

                    <asp:Label ID="lblMessage" runat="server" Text="" Font-Size="Small" Display="Dynamic"></asp:Label>

                    <asp:Button ID="btnRegister" runat="server" Text="ĐĂNG KÝ" OnClick="btnRegister_Click" 
                        CssClass="w-full bg-pink-600 hover:bg-pink-700 text-white font-bold py-4 rounded-2xl text-lg transition cursor-pointer" />
                </div>
            </div>

            <div class="text-center pb-8">
                <p class="text-sm text-gray-600">
                    Đã có tài khoản? 
                    <a href="login.aspx" class="text-pink-600 font-semibold hover:underline">Đăng nhập</a>
                </p>
            </div>
        </div>
    </form>

</body>
</html>