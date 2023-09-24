# convert this code to dart

parkingspace=[34,23,43,10]
space1=32
space2=21
space3=23
space4=4
space=[space1,space2,space3,space4]
for i in range(4):
    minspace= parkingspace[i]-5
    if space[i]>minspace:
        print("parking is almost full")
    else:
        print("parking is not full available space =", parkingspace[i]-space[i] )
def calculate_pricing(parking_space, space, base_price, discount_threshold, discount_rate):
    # Calculate the available space for each parking spot
    available_space = [parking_space[i] - space[i] for i in range(len(parking_space))]

    # Calculate the total available space
    total_available_space = sum(available_space)

    # Calculate the average available space
    average_available_space = total_available_space / len(parking_space)

    # Calculate the discount based on the average available space
    if average_available_space < discount_threshold:
        discount = base_price * discount_rate
    else:
        discount = 0

    # Calculate the dynamic price
    dynamic_price = base_price - discount

    return dynamic_price

# Example usage:
parking_space = [34, 23, 43, 10]
space = [32, 21, 23, 4]
base_price = 10  # Set your base price per parking space
discount_threshold = 10  # Set the threshold for applying a discount
discount_rate = 0.2  # Set the discount rate (20%)

dynamic_price = calculate_pricing(parking_space, space, base_price, discount_threshold, discount_rate)
print(f"Dynamic Price: ${dynamic_price:.2f}")
