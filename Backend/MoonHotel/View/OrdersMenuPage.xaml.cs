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
        private readonly uint customerId;

        public OrdersMenuPage(uint customerId)
        {
            InitializeComponent();
            this.customerId = customerId;
        }

        private void Book_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new BookOrderPage(customerId));
        }

        private void Food_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new FoodOrderPage(customerId));
        }

        private void Shop_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ShopProductOrderPage(customerId));
        }

        private void Facilities_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new FacilitiesOrderPage(customerId));
        }

        private void Review_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ReviewPage(customerId));
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
