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
    public partial class NewEmployeePage : Page
    {
        private DatabaseManager db;

        public NewEmployeePage()
        {
            InitializeComponent();
            db = new DatabaseManager();
            LoadRoles();
        }

        private void LoadRoles()
        {
            List<Role> roles = db.GetAllRoles();
            RoleComboBox.ItemsSource = roles;
        }

        private void Register_Click(object sender, RoutedEventArgs e)
        {
            if (!int.TryParse(SalaryBox.Text.Trim(), out int salary))
            {
                MessageBox.Show("Invalid salary.");
                return;
            }

            if (!uint.TryParse(HotelIdBox.Text.Trim(), out uint hotelId))
            {
                MessageBox.Show("Invalid Hotel ID.");
                return;
            }

            if (RoleComboBox.SelectedValue == null)
            {
                MessageBox.Show("Please select a role.");
                return;
            }

            Staff staff = new Staff
            {
                FirstName = FirstNameBox.Text.Trim(),
                LastName = LastNameBox.Text.Trim(),
                UserName = UserNameBox.Text.Trim(),
                Password = PasswordBox.Password,
                Salary = salary,
                HotelID = hotelId,
                RoleID = (uint)RoleComboBox.SelectedValue,
                HireDate = DateTime.Now
            };

            try
            {
                db.AddStaff(staff);

                MessageBox.Show($" Employee {staff.FirstName} {staff.LastName} registered successfully!");

                ClearFields();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void ClearFields()
        {
            FirstNameBox.Clear();
            LastNameBox.Clear();
            UserNameBox.Clear();
            PasswordBox.Clear();
            SalaryBox.Clear();
            HotelIdBox.Clear();
            RoleComboBox.SelectedIndex = -1;
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
