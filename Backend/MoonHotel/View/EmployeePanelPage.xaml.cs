using MoonHotel.Models;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace MoonHotel.View
{
    public partial class EmployeePanelPage : Page
    {
        private Staff currentStaff;

        public EmployeePanelPage(Staff staff)
        {
            InitializeComponent();

            currentStaff = staff;

        }

        private void ManageBooks_Click(object sender, RoutedEventArgs e) => NavigationService.Navigate(new ManageBooksPage());

        private void ManageFoods_Click(object sender, RoutedEventArgs e) => NavigationService.Navigate(new ManageFoodsPage());

        private void ManageShop_Click(object sender, RoutedEventArgs e) => NavigationService.Navigate(new ManageShopPage());

        private void ManageFacilities_Click(object sender, RoutedEventArgs e) => NavigationService.Navigate(new ManageFacilitiesPage());

        private void ManageRooms_Click(object sender, RoutedEventArgs e) => NavigationService.Navigate(new ManageRoomsPage());

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}