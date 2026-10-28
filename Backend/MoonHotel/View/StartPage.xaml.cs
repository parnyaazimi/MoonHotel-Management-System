using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using MoonHotel.Backend;
using MoonHotel.Models;
using MySql.Data.MySqlClient;

namespace MoonHotel.View
{
    public partial class StartPage : Page
    {
        private DatabaseManager db = new DatabaseManager();
        public StartPage()
        {
            InitializeComponent();

        }

        private void enter(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new View.HomePage());
        }
    }
}
