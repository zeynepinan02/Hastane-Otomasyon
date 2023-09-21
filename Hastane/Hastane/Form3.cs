using System;
using System.Collections.Generic;
using Npgsql;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Hastane
{
    public partial class Form3 : Form
    {
        public Form3()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432; Database=HastaneOtamasyonu; userID=postgres; password=HBMz6102");


        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" || textBox2.Text == "" || textBox3.Text == "")
                MessageBox.Show("TC, tarih, klinik adı alanlarını doldurunuz!");
            else
            {
                baglanti.Open();

                NpgsqlCommand SqlKomut = new NpgsqlCommand("SELECT * from \"Hasta\" ", baglanti);
                NpgsqlDataReader alinan_veri;
                alinan_veri = SqlKomut.ExecuteReader();

                int kontrol = 0;

                while (alinan_veri.Read())
                {
                    if (textBox2.Text == alinan_veri["TC"].ToString())
                    {
                        kontrol = 1;
                    }
                }

                alinan_veri.Close();               

                NpgsqlCommand SqlKomut3 = new NpgsqlCommand("SELECT * from \"Klinik\" ", baglanti);
                NpgsqlDataReader alinan_veri3;
                alinan_veri3 = SqlKomut3.ExecuteReader();

                int kontrol3 = 0;
                string klinikNo = "";

                while (alinan_veri3.Read())
                {
                    if (textBox3.Text == alinan_veri3["klinikAdi"].ToString())
                    {
                        kontrol3 = 1;
                        klinikNo = alinan_veri3["klinikNo"].ToString();
                    }
                }

                alinan_veri3.Close();

                if (kontrol == 1 && kontrol3 == 1)
                {
                    string sorgu = "insert into \"Randevu\" (\"hastaTC\",\"randevuTarih\") values(@p1,@p2) ";
                    NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
                    da.Parameters.AddWithValue("@p1", Convert.ToInt64(textBox2.Text));
                    da.Parameters.AddWithValue("@p2", textBox1.Text);

                    da.ExecuteNonQuery();

                    MessageBox.Show("Randevu başarıyla alındı.");
                }

                else
                {
                    MessageBox.Show("Bilgileriniz yanlış.");
                }

                baglanti.Close();
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            Form3 formKapa = new Form3();
            formKapa.Close();
            Form1 form1 = new Form1();
            form1.Show();
        }
    }
}
