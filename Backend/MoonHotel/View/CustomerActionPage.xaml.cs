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

    public partial class CustomerActionPage : Page
    {
        private uint _customerId;

        public CustomerActionPage(uint customerId)
        {
            InitializeComponent();
            _customerId = customerId;
        }

        private void Reserve_Click(object sender, RoutedEventArgs e)
        {

            NavigationService?.Navigate(new ReservationPage(_customerId));
        }

        private void Home_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new HomePage());
        }
    }
}
