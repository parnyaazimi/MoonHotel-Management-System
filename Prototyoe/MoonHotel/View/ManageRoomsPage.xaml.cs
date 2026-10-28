using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace MoonHotel.View
{
    public partial class ManageRoomsPage : Page
    {
        public ManageRoomsPage() { InitializeComponent(); }
        private void BackToPanel_Click(object sender, RoutedEventArgs e) 
        { 
            NavigationService.GoBack();
        }
    }
}