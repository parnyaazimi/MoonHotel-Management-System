using MoonHotel.Backend;
using MoonHotel.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace MoonHotel.View
{
    public partial class NewCustomerPage : Page
    {
        private DatabaseManager db;
        private List<TextBox> phoneTextBoxes;

        public NewCustomerPage()
        {
            InitializeComponent();

            db = new DatabaseManager();
            phoneTextBoxes = new List<TextBox>();

            phoneTextBoxes.Add(txtPhone1);
        }

        private void AddPhone_Click(object sender, RoutedEventArgs e)
        {
            TextBox newPhoneTextBox = new TextBox
            {
                Width = 400,
                Margin = new Thickness(120, 10, 0, 0)
            };

            phoneTextBoxes.Add(newPhoneTextBox);
            PhoneStack.Children.Add(newPhoneTextBox);
        }

        private void Register_Click(object sender, RoutedEventArgs e)
        {
            if (db.CustomerExistsByNationalID(txtNationalID.Text.Trim()))
            {
                MessageBox.Show("A customer with this National ID already exists.");
                return;
            }

            try
            {
                if (!ValidateInputs())
                    return;

                Customer customer = new Customer
                {
                    FirstName = txtFirstName.Text.Trim(),
                    LastName = txtLastName.Text.Trim(),
                    NationalID = txtNationalID.Text.Trim(),
                    BirthDate = dpBirthDate.SelectedDate,
                    City = txtCity.Text.Trim(),
                    Street = txtStreet.Text.Trim(),
                    PostalCode = txtPostalCode.Text.Trim()
                };

                List<string> phoneNumbers = phoneTextBoxes
                    .Select(tb => tb.Text.Trim())
                    .Where(phone => !string.IsNullOrWhiteSpace(phone))
                    .Distinct()
                    .ToList();

                uint newCustomerId = db.AddCustomer(customer, phoneNumbers);

                MessageBox.Show("Customer registered successfully.\nCustomer ID: " + newCustomerId,
                                "Success",
                                MessageBoxButton.OK,
                                MessageBoxImage.Information);


                NavigationService?.Navigate(new CustomerActionPage((newCustomerId)));
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred while registering customer:\n" + ex.Message,"Error",
                                MessageBoxButton.OK,
                                MessageBoxImage.Error);
            }
        }

        private bool ValidateInputs()
        {
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                MessageBox.Show("First Name is required.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                MessageBox.Show("Last Name is required.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtNationalID.Text))
            {
                MessageBox.Show("National ID is required.");
                return false;
            }

            if (txtNationalID.Text.Trim().Length != 10)
            {
                MessageBox.Show("National ID must be 10 digits.");
                return false;
            }

            List<string> phones = phoneTextBoxes
                .Select(tb => tb.Text.Trim())
                .Where(phone => !string.IsNullOrWhiteSpace(phone))
                .ToList();

            if (phones.Count == 0)
            {
                MessageBox.Show("At least one phone number is required.");
                return false;
            }

            return true;
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }
    }
}
