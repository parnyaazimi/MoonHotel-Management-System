using MoonHotel.Models;
using System;
using System.Windows;
using System.Windows.Controls;
using MoonHotel.Backend;

namespace MoonHotel.View
{
    public partial class FoodOrderPage : Page
    {
        private readonly uint customerId;
        private readonly DatabaseManager db = new DatabaseManager();

        public FoodOrderPage(uint customerId)
        {
            InitializeComponent();
            this.customerId = customerId;

            LoadFoods();
            LoadCategories();
            LoadSections();
        }

        private void LoadFoods()
        {
            FoodBox.ItemsSource = db.GetFoods();
        }

        private void LoadCategories()
        {
            CategoryBox.ItemsSource = db.GetFoodCategories();
        }

        private void LoadSections()
        {
            SectionBox.ItemsSource = db.GetFoodSections();
        }

        private void SubmitOrder_Click(object sender, RoutedEventArgs e)
        {
            if (FoodBox.SelectedValue == null)
            {
                MessageBox.Show("Select a food first.");
                return;
            }

            uint foodId = Convert.ToUInt32(FoodBox.SelectedValue);
            int quantity = int.Parse(QuantityBox.Text);

            decimal total = db.CreateFoodOrder(customerId, foodId, quantity);

            MessageBox.Show($"Order registered \nTotal Invoice: {total:0.00}");
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new HomePage());
        }
    }
}
