using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Hastane
{
    public partial class Form4 : Form
    {
        public Form4()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432; Database=HastaneOtamasyonu; userID=postgres; password=HBMz6102");

        private void button1_Click(object sender, EventArgs e)
        {
            

            if (textBox1.Text == "" || textBox2.Text == "" || textBox3.Text == "")
                MessageBox.Show("TC,ad,soyad,cinsiyet alanlarını doldurunuz!");
            else
            {
                baglanti.Open();

                NpgsqlCommand SqlKomut = new NpgsqlCommand("SELECT * from \"Hasta\" ", baglanti);
                NpgsqlDataReader alinan_veri;
                alinan_veri = SqlKomut.ExecuteReader();

                int kontrol = 0;

                while (alinan_veri.Read())
                {
                    if (textBox3.Text == alinan_veri["TC"].ToString())
                    {
                        kontrol = 1;
                    }
                }

                alinan_veri.Close();

                NpgsqlCommand SqlKomut2 = new NpgsqlCommand("SELECT * from \"Personel\" ", baglanti);
                NpgsqlDataReader alinan_veri2 = SqlKomut2.ExecuteReader();

                int kontrol2 = 0;

                while (alinan_veri2.Read())
                {
                    if (textBox2.Text == alinan_veri2["TC"].ToString())
                    {
                        kontrol2 = 1;
                    }
                }

                alinan_veri2.Close();

                NpgsqlCommand SqlKomut3 = new NpgsqlCommand("SELECT * from \"Ilac\" ", baglanti);
                NpgsqlDataReader alinan_veri3;
                alinan_veri3 = SqlKomut3.ExecuteReader();

                int kontrol3 = 0;
                string ilacId="";

                while (alinan_veri3.Read())
                {
                    if (textBox1.Text == alinan_veri3["ilacAdi"].ToString())
                    {
                        kontrol3 = 1;
                        ilacId = alinan_veri3["ilacId"].ToString();
                    }
                }

                alinan_veri3.Close();

                NpgsqlCommand SqlKomut4 = new NpgsqlCommand("SELECT * from \"Recete\" ", baglanti);
                NpgsqlDataReader alinan_veri4;
                alinan_veri4 = SqlKomut4.ExecuteReader();

                int kontrol4 = 0;

                while (alinan_veri4.Read())
                {
                    if (textBox4.Text == alinan_veri4["receteNo"].ToString())
                    {
                        kontrol4 = 1;
                    }
                }

                alinan_veri4.Close();

                if (kontrol == 1 && kontrol2 == 1 && kontrol3 == 1 && kontrol4 == 0)
                {
                    string sorgu = "insert into \"Recete\" (\"doktorTC\",\"hastaTC\",\"ilacId\" ,\"receteNo\") values(@p1,@p2,@p3,@p4) ";
                    NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
                    da.Parameters.AddWithValue("@p1", Convert.ToInt64(textBox2.Text));
                    da.Parameters.AddWithValue("@p2", Convert.ToInt64(textBox3.Text));
                    da.Parameters.AddWithValue("@p3", int.Parse(ilacId));
                    da.Parameters.AddWithValue("@p4", int.Parse(textBox4.Text));

                    da.ExecuteNonQuery();

                    MessageBox.Show("Reçete başarıyla eklendi");
                }

                else
                {
                    MessageBox.Show("girdiğiniz bilgler doğrulanamadı.Lütfen tekrar kontrol ediniz");
                }

                baglanti.Close();
            }

            
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button8_Click(object sender, EventArgs e)
        {
            Form4 formKapa = new Form4();
            formKapa.Close();
            Form1 form1 = new Form1();
            form1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "")
                MessageBox.Show("ilac adı alanlanını doldurunuz!");
            else
            {
                baglanti.Open();

                NpgsqlCommand SqlKomut3 = new NpgsqlCommand("SELECT * from \"Ilac\" ", baglanti);
                NpgsqlDataReader alinan_veri3;
                alinan_veri3 = SqlKomut3.ExecuteReader();

                int kontrol3 = 0;

                while (alinan_veri3.Read())
                {
                    if (textBox1.Text == alinan_veri3["ilacAdi"].ToString())
                    {
                        kontrol3 = 1;
                    }
                }

                alinan_veri3.Close();

                if (kontrol3 == 1)
                {
                    string sorgu2 = "select * from ilacSil(@p1)";
                    NpgsqlCommand da2 = new NpgsqlCommand(sorgu2, baglanti);

                    da2.Parameters.AddWithValue("@p1",textBox1.Text);

                    da2.ExecuteNonQuery();


                    MessageBox.Show("ilac başarılı bir şekilde silinmiştir.");
                }

                else
                {
                    MessageBox.Show("böyle bir ilac zaten bulunmuyor.");
                }

                baglanti.Close();
            }
        }
    }
}
