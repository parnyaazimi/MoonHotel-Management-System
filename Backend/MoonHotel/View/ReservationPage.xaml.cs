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

    public partial class ReservationPage : Page
    {
        private DatabaseManager db = new DatabaseManager();
        private uint _currentCustomerId;

        public ReservationPage(uint customerId)
        {
            InitializeComponent();
            _currentCustomerId = customerId;
            cmbHotel.ItemsSource = db.GetHotels();
        }

        private void Confirm_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (cmbHotel.SelectedValue == null ||
                    string.IsNullOrWhiteSpace(txtRoomNumber.Text) ||
                    dpCheckIn.SelectedDate == null ||
                    dpCheckOut.SelectedDate == null)
                {
                    MessageBox.Show("Please fill all required fields!");
                    return;
                }

                if (dpCheckOut.SelectedDate <= dpCheckIn.SelectedDate)
                {
                    MessageBox.Show("Check-Out date must be after Check-In date!");
                    return;
                }

                uint hotelId = (uint)cmbHotel.SelectedValue;

                Reservation newRes = new Reservation
                {
                    CustomerID = _currentCustomerId,
                    NumberOfGuests = int.Parse(txtGuests.Text),
                    CheckInDate = dpCheckIn.SelectedDate,
                    CheckOutDate = dpCheckOut.SelectedDate,
                    StatusID = 1
                };

                bool success = db.CreateReservationWithAvailability(
                    hotelId,
                    txtRoomNumber.Text,
                    newRes
                );

                if (success)
                {
                    MessageBox.Show("✅ Reservation completed successfully!");
                    NavigationService.Navigate(new HomePage());
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }



        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
