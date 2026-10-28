using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace MoonHotel.View
{
    public partial class ManageShopPage : Page
    {
        public ManageShopPage() { InitializeComponent(); }
        private void BackToPanel_Click(object sender, RoutedEventArgs e) 
        { 
            NavigationService.GoBack(); 
        }
    }
}