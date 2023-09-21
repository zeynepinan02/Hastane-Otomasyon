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
    public partial class Form5 : Form
    {
        public Form5()
        {
            InitializeComponent();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432; Database=HastaneOtamasyonu; userID=postgres; password=HBMz6102");

        private void button4_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            string sorgu2 = "select * from toplammesai()";

            NpgsqlCommand komut = new NpgsqlCommand(sorgu2, baglanti);
            NpgsqlDataReader dr = komut.ExecuteReader();

            while(dr.Read())
            {
                textBox1.Text = dr.GetValue(0).ToString();
            }

            baglanti.Close();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            baglanti.Open();

            string sorgu1 = "select * from toplammaas()";
            NpgsqlCommand komut2 = new NpgsqlCommand(sorgu1, baglanti);
            NpgsqlDataReader dr2 = komut2.ExecuteReader();

            while (dr2.Read())
            {
                textBox4.Text = dr2.GetValue(0).ToString();
            }

            baglanti.Close();
        }
    }
}
