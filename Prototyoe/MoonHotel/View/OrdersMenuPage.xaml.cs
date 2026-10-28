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
    public partial class OrdersMenuPage : Page
    {
        public OrdersMenuPage()
        {
            InitializeComponent();
        }

        private void Book_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new BookOrderPage());
        }

        private void Food_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new FoodOrderPage());
        }

        private void Shop_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ShopProductOrderPage());
        }

        private void Facilities_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new FacilitiesOrderPage());
        }

        private void Review_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ReviewPage());
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
