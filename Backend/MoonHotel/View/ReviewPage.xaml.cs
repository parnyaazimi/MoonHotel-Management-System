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
using MoonHotel.Backend;
using MoonHotel.Models;

namespace MoonHotel.View
{
    public partial class ReviewPage : Page
    {
        private readonly uint customerId;
        private DatabaseManager db;

        public ReviewPage(uint customerId)
        {
            InitializeComponent();
            this.customerId = customerId;
            db = new DatabaseManager();

            LoadRatings();
        }

        private void LoadRatings()
        {
            List<Rating> ratings = db.GetAllRatings();
            RatingComboBox.ItemsSource = ratings;
        }

        private void Submit_Click(object sender, RoutedEventArgs e)
        {
            if (!uint.TryParse(HotelIdTextBox.Text.Trim(), out uint hotelId))
            {
                MessageBox.Show("Invalid Hotel ID.");
                return;
            }

            if (RatingComboBox.SelectedValue == null)
            {
                MessageBox.Show("Please select a rating.");
                return;
            }

            string comment = CommentTextBox.Text.Trim();

            Review review = new Review
            {
                Comment = comment,
                ReviewDate = DateTime.Now,
                CustomerID = customerId,
                HotelID = hotelId,
                RatingID = (uint)RatingComboBox.SelectedValue
            };

            try
            {
                db.AddReview(review);

                MessageBox.Show("Review submitted successfully.");

                CommentTextBox.Clear();
                HotelIdTextBox.Clear();
                RatingComboBox.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new OrdersMenuPage(customerId));
        }
    }
}


