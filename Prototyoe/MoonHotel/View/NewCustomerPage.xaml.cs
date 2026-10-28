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
    public partial class NewCustomerPage : Page
    {
        public NewCustomerPage()
        {
            InitializeComponent();
        }

        private void AddPhone_Click(object sender, RoutedEventArgs e)
        {
            TextBox phoneBox = new TextBox();
            phoneBox.Width = 300;
            phoneBox.Margin = new Thickness(150, 5, 0, 0);

            PhoneStack.Children.Add(phoneBox);
        }

        private void Reservation_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ReservationPage());
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
