using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MoonHotel.Backend;
using MoonHotel.Models;

namespace MoonHotel.View
{

    public partial class ReportsPage : Page
    {
        private DatabaseManager db = new DatabaseManager();

        public ReportsPage()
        {
            InitializeComponent();
        }
        private void GenerateReport_Click(object sender, RoutedEventArgs e)
        {
            int index = reportSelector.SelectedIndex;

            switch (index)
            {
                case 0: reportGrid.ItemsSource = db.GetHotelRevenueReport(); break;
                case 1: reportGrid.ItemsSource = db.GetCustomerRanking(); break;
                case 2: reportGrid.ItemsSource = db.GetReservationReport(); break;
                case 3: reportGrid.ItemsSource = db.GetReservationServices(); break;
                case 4: reportGrid.ItemsSource = db.GetHotelRatings(); break;
                case 5: reportGrid.ItemsSource = db.GetTopFoods(); break;
                case 6: reportGrid.ItemsSource = db.GetBooksReport(); break;
                case 7: reportGrid.ItemsSource = db.GetStaffReport(); break;
                case 8: reportGrid.ItemsSource = db.GetOrdersReport(); break;
                case 9: reportGrid.ItemsSource = db.GetUnpaidInvoices(); break;
            }

            if (reportGrid.Items.Count == 0)
            {
                MessageBox.Show("No data found! Make sure your database tables are not empty.", "Info");
            }
        }
        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void reportGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
