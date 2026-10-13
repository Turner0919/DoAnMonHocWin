using System.Drawing.Drawing2D;

namespace DoAnQuanLyXeMay
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Form_DangKy f2 = new Form_DangKy();
            f2.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            
            // Lấy chuỗi nhập vào từ TextBox (thay txtLogin và txtPassword đúng theo Name trên Form của bạn)
            string user = txtLogin.Text;
            string pass = txtPassword.Text;

            if (KiemTraDangNhap(user, pass))
            {
               // MessageBox.Show("Đăng nhập thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

                // 1. Ẩn Form Login
                this.Hide();

                // 2. Mở Form Account
                Form_Account frmAccount = new Form_Account();
                frmAccount.ShowDialog();

                // 3. Khi Form Account đóng lại (ví dụ bấm Đăng xuất) -> Hiện lại Form Login
                this.Show();

                // Dọn sạch mật khẩu cũ để sẵn sàng cho lần đăng nhập sau
                txtPassword.Clear();
            }
            else
            {
                MessageBox.Show("Tài khoản hoặc mật khẩu không chính xác!", "Lỗi đăng nhập", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtPassword.Clear();
                txtPassword.Focus(); // Đưa con trỏ chuột về lại ô mật khẩu
            }
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            
        }
        private bool KiemTraDangNhap(string username, string password)
        {
            // Tài khoản và mật khẩu cố định
            string userMacDinh = "User123";
            string passMacDinh = "1234";

            // Kiểm tra tính đúng đắn (dùng StringComparison.Ordinal để phân biệt chính xác hoa/thường)
            if (string.Equals(username.Trim(), userMacDinh, StringComparison.Ordinal) &&
                string.Equals(password, passMacDinh, StringComparison.Ordinal))
            {
                return true;
            }

            return false;
        }


    }
}
