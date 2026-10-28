using MoonHotel.Backend;
using MoonHotel.Models;
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
    public partial class ExistingEmployeeLoginPage : Page
    {
        private DatabaseManager db;

        public ExistingEmployeeLoginPage()
        {
            InitializeComponent();
            db = new DatabaseManager();
        }

        private void Login_Click(object sender, RoutedEventArgs e)
        {
            string username = UsernameBox.Text.Trim();
            string password = PasswordBox.Password;

            if (string.IsNullOrWhiteSpace(username) ||string.IsNullOrWhiteSpace(password))
            {
                MessageBox.Show("Please enter username and password.");
                return;
            }

            try
            {
                Staff? staff = db.AuthenticateEmployee(username, password);

                if (staff != null)
                {
                    MessageBox.Show(
                        $"Welcome {staff.FirstName} {staff.LastName}!",
                        "Login Successful",
                        MessageBoxButton.OK,
                        MessageBoxImage.Information);

                    NavigationService.Navigate(new EmployeePanelPage(staff));
                }
                else
                {
                    MessageBox.Show(
                        "Invalid username or password.",
                        "Login Failed",
                        MessageBoxButton.OK,
                        MessageBoxImage.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database error: " + ex.Message);
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
