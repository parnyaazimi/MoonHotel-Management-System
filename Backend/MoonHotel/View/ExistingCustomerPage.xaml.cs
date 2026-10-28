using MoonHotel.Backend;
using System;
using System.Collections.Generic;
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


namespace MoonHotel.View
{
    public partial class ExistingCustomerPage : Page
    {
        private DatabaseManager db;
        public ExistingCustomerPage()
        {
            db = new DatabaseManager();
            InitializeComponent();
        }

        private void Orders_Click(object sender, RoutedEventArgs e)
        {
            string firstName = CustomerFirstNameBox.Text.Trim();
            string lastName = CustomerLastNameBox.Text.Trim();
            string nationalId = NationalIdBox.Text.Trim();

            if (string.IsNullOrWhiteSpace(firstName) ||string.IsNullOrWhiteSpace(lastName) ||string.IsNullOrWhiteSpace(nationalId))
            {
                MessageBox.Show("Please fill in all fields.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                uint? customerId = db.GetCustomerId(nationalId, firstName, lastName);

                if (customerId != null)
                {
                    NavigationService.Navigate(new OrdersMenuPage(customerId.Value));
                }
                else
                {
                    MessageBox.Show("Customer not found.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            catch (System.Exception ex)
            {
                MessageBox.Show("Error while checking customer: " + ex.Message,"Database Error",MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
