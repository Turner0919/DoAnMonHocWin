namespace DoAnQuanLyXeMay
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            label1 = new Label();
            txtLogin = new TextBox();
            txtPassword = new TextBox();
            label2 = new Label();
            label3 = new Label();
            panel1 = new Panel();
            button3 = new Button();
            button1 = new Button();
            panel1.SuspendLayout();
            SuspendLayout();
            // 
            // label1
            // 
            label1.Anchor = AnchorStyles.Top;
            label1.AutoSize = true;
            label1.BackColor = SystemColors.Highlight;
            label1.Font = new Font("Algerian", 24F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.ForeColor = Color.AliceBlue;
            label1.Location = new Point(170, 20);
            label1.Name = "label1";
            label1.Size = new Size(325, 45);
            label1.TabIndex = 0;
            label1.Text = "LOGIN ACCOUNT";
            label1.Click += label1_Click;
            // 
            // txtLogin
            // 
            txtLogin.Location = new Point(211, 111);
            txtLogin.Name = "txtLogin";
            txtLogin.Size = new Size(365, 27);
            txtLogin.TabIndex = 1;
            txtLogin.WordWrap = false;
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(211, 181);
            txtPassword.Name = "txtPassword";
            txtPassword.Size = new Size(365, 27);
            txtPassword.TabIndex = 2;
            txtPassword.TextChanged += textBox2_TextChanged;
            // 
            // label2
            // 
            label2.Anchor = AnchorStyles.None;
            label2.AutoSize = true;
            label2.BackColor = SystemColors.ButtonFace;
            label2.Font = new Font("Algerian", 16.2F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label2.Location = new Point(34, 111);
            label2.Name = "label2";
            label2.Size = new Size(98, 31);
            label2.TabIndex = 3;
            label2.Text = "Login:";
            // 
            // label3
            // 
            label3.Anchor = AnchorStyles.Top;
            label3.AutoSize = true;
            label3.BackColor = SystemColors.ButtonFace;
            label3.Font = new Font("Algerian", 16.2F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label3.Location = new Point(34, 177);
            label3.Name = "label3";
            label3.Size = new Size(165, 31);
            label3.TabIndex = 4;
            label3.Text = "PASSWORD:";
            // 
            // panel1
            // 
            panel1.Anchor = AnchorStyles.None;
            panel1.BackColor = Color.FromArgb(255, 192, 128);
            panel1.Controls.Add(button3);
            panel1.Controls.Add(button1);
            panel1.Controls.Add(txtLogin);
            panel1.Controls.Add(label1);
            panel1.Controls.Add(label2);
            panel1.Controls.Add(label3);
            panel1.Controls.Add(txtPassword);
            panel1.Location = new Point(326, 162);
            panel1.Name = "panel1";
            panel1.Size = new Size(646, 301);
            panel1.TabIndex = 5;
            // 
            // button3
            // 
            button3.BackColor = Color.Yellow;
            button3.Font = new Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, 163);
            button3.ForeColor = Color.Red;
            button3.Location = new Point(223, 239);
            button3.Name = "button3";
            button3.Size = new Size(110, 42);
            button3.TabIndex = 7;
            button3.Text = "Login";
            button3.UseVisualStyleBackColor = false;
            button3.Click += button3_Click;
            // 
            // button1
            // 
            button1.BackColor = Color.PaleGreen;
            button1.Font = new Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, 163);
            button1.ForeColor = SystemColors.MenuHighlight;
            button1.Location = new Point(358, 239);
            button1.Name = "button1";
            button1.Size = new Size(110, 42);
            button1.TabIndex = 5;
            button1.Text = "Sign Up";
            button1.UseVisualStyleBackColor = false;
            button1.Click += button1_Click_1;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            BackgroundImage = Properties.Resources.Gemini_Generated_Image_be3pi1be3pi1be3p;
            BackgroundImageLayout = ImageLayout.Stretch;
            ClientSize = new Size(1264, 642);
            Controls.Add(panel1);
            DoubleBuffered = true;
            Icon = (Icon)resources.GetObject("$this.Icon");
            Name = "Form1";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Quản Lý Bảo Dưỡng Xe Máy";
            Load += Form1_Load;
            panel1.ResumeLayout(false);
            panel1.PerformLayout();
            ResumeLayout(false);
        }

        #endregion

        private Label label1;
        private TextBox txtLogin;
        private TextBox txtPassword;
        private Label label2;
        private Label label3;
        private Panel panel1;
        private Button button1;
        private Button button3;
    }
}
