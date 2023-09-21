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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432; Database=HastaneOtamasyonu; userID=postgres; password=HBMz6102");


        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" )
                MessageBox.Show("TC alanını doldurunuz!");
            else
            {
                string TC = textBox1.Text;
                string sorgu = "select * from \"Hasta\"  where \"TC\" = '" + TC + "'";
                NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
                DataSet ds = new DataSet();
                da.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0];
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            string sorgu = "select * from \"Hasta\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void button6_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" || textBox6.Text == "" || textBox5.Text == "" || textBox4.Text == "")
                MessageBox.Show("TC,ad,soyad,cinsiyet alanlarını doldurunuz!");

            else
            {
                baglanti.Open();


                NpgsqlCommand SqlKomut3 = new NpgsqlCommand("SELECT * from \"Hasta\" ", baglanti);
                NpgsqlDataReader alinan_veri3;
                alinan_veri3 = SqlKomut3.ExecuteReader();

                int kontrol3 = 0;

                while (alinan_veri3.Read())
                {
                    if (textBox1.Text == alinan_veri3["TC"].ToString())
                    {
                        kontrol3 = 1;
                    }
                }

                alinan_veri3.Close();

                if (kontrol3 != 1)
                {
                    string sorgu = "insert into \"Hasta\" (\"TC\",\"ad\",\"soyad\",\"cinsiyet\") values(@p1,@p2,@p3,@p4) ";
                    NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
                    da.Parameters.AddWithValue("@p1", Convert.ToInt64(textBox1.Text));
                    da.Parameters.AddWithValue("@p2", textBox6.Text);
                    da.Parameters.AddWithValue("@p3", textBox5.Text);
                    da.Parameters.AddWithValue("@p4", textBox4.Text);

                    da.ExecuteNonQuery();

                    MessageBox.Show("hasta başarılı bir şekilde eklenmiştir.");
                }

                

                else
                {
                    MessageBox.Show("böyle bir hasta zaten buunuyor.");
                }

                baglanti.Close();
            }
        }

       

        private void button5_Click(object sender, EventArgs e)
        {
            if (textBox1.Text == "" || textBox6.Text == "" || textBox5.Text == "" || textBox4.Text == "")
                MessageBox.Show("TC,ad,soyad,cinsiyet alanlarını doldurunuz!");
            else
            {
                baglanti.Open();

                NpgsqlCommand SqlKomut3 = new NpgsqlCommand("SELECT * from \"Hasta\" ", baglanti);
                NpgsqlDataReader alinan_veri3;
                alinan_veri3 = SqlKomut3.ExecuteReader();

                int kontrol3 = 0;

                while (alinan_veri3.Read())
                {
                    if (textBox1.Text == alinan_veri3["TC"].ToString())
                    {
                        kontrol3 = 1;
                    }
                }

                alinan_veri3.Close();

                if (kontrol3 == 1)
                {

                    string sorgu = "update \"Hasta\" set \"ad\" = @p1,\"soyad\" = @p2,\"cinsiyet\" = @p3 where \"TC\"=@p4 ";
                    NpgsqlCommand da = new NpgsqlCommand(sorgu, baglanti);
                    da.Parameters.AddWithValue("@p1", textBox6.Text);
                    da.Parameters.AddWithValue("@p2", textBox5.Text);
                    da.Parameters.AddWithValue("@p3", textBox4.Text);
                    da.Parameters.AddWithValue("@p4", Convert.ToInt64(textBox1.Text));

                    da.ExecuteNonQuery();

                    string sorgu2 = "select * from \"Hasta\"";
                    NpgsqlDataAdapter da2 = new NpgsqlDataAdapter(sorgu2, baglanti);
                    DataSet ds = new DataSet();
                    da2.Fill(ds);
                    dataGridView1.DataSource = ds.Tables[0];
                }

                else
                {
                    MessageBox.Show("böyle bir hasta zaten bulunmuyor.");
                }

                baglanti.Close();
            }
            
        }

        private void button8_Click(object sender, EventArgs e)
        {
            Form2 formKapa = new Form2();
            formKapa.Close();
            Form1 form1 = new Form1();
            form1.Show();
        }
    }
}
