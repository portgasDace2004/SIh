import random
from statistics import mean

# Simulated function to get real-time traffic data for a parking spot
def get_traffic_data(parking_spot_id):
    # Simulated traffic percentage (0-100%)
    return random.uniform(0, 100)

# Simulated function to get historical parking data
def get_historical_data(parking_spot_id):
    # Simulated historical prices for the last 7 days
    return [random.uniform(4, 10) for _ in range(7)]

# Pricing algorithm
def calculate_dynamic_price(parking_spot_id):
    base_price = 5  # Base parking price
    max_price = 20  # Maximum allowable price
    traffic_threshold = 70  # Threshold for considering traffic

    # Get real-time traffic data and historical data
    current_traffic = get_traffic_data(parking_spot_id)
    historical_prices = get_historical_data(parking_spot_id)

    # Calculate dynamic pricing based on traffic and historical data
    if current_traffic > traffic_threshold:
        price_multiplier = 1 + (current_traffic - traffic_threshold) / 100
    else:
        price_multiplier = 1 - (traffic_threshold - current_traffic) / 100

    # Calculate the final price while considering historical data
    if historical_prices:
        average_historical_price = mean(historical_prices)
        price = base_price * price_multiplier + (average_historical_price * 0.2)
    else:
        price = base_price * price_multiplier

    # Ensure the price does not exceed the maximum allowable price
    return min(price, max_price)

# Example usage
parking_spot_id = 123
dynamic_price = calculate_dynamic_price(parking_spot_id)
print(f"Dynamic Price for Parking Spot {parking_spot_id}: ${dynamic_price:.2f}")